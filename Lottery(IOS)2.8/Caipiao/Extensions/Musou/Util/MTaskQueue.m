//
//  MQueueRequest.m
//  Fun
//
//  Created by luo danal on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MTaskQueue.h"

@implementation MTask
@synthesize tid = _tid, url = _url, target = _target;

+ (id)taskWithTid:(NSInteger)tid url:(NSString *)url target:(id)target{
    MTask *task = [[[self alloc] init] autorelease];
    task.tid = tid;
    task.url = url;
    task.target = target;
    return task;
}

- (void)dealloc{
    [_url release];
    [super dealloc];
}

@end

#pragma mark - =====================

@interface MTaskQueue () {
}

- (void)runNextTask;
- (void)runTaskAtIndex:(NSInteger)index;
@end

#pragma mark - ======================

@implementation MTaskQueue
@synthesize tag = _tag;
@synthesize maxConcurrent = _maxConcurrent;
@synthesize tasks = _tasks;
@synthesize queues = _queues;
@synthesize running = _running;
@synthesize paused = _paused;

static MTaskQueue *_sharedQueue = nil;

+ (id)sharedQueue{
    @synchronized(self){
        if (_sharedQueue == nil) {
            _sharedQueue = [[self alloc] init];
        }
        return _sharedQueue;
    }
}

+ (id)queueWithTag:(NSInteger)tag{
    NSString *key = [NSString stringWithFormat:@"queue-%ld",(long)tag];
    MTaskQueue *q = [[[self sharedQueue] queues] objectForKey:key];
    if (q == nil){
        q = [[[self alloc] init] autorelease];
        q.tag = tag;
        [[[self sharedQueue] queues] setObject:q forKey:key];
    }
    return q;
}

- (void)dealloc{
    [_tasks release]; _tasks = nil;
    [_queues release]; _queues = nil;
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        _tasks = [[NSMutableArray alloc] init];
        _queues = [[NSMutableDictionary alloc] init];
        self.maxConcurrent = 5;
        _taskPauseBlock = NULL;
    }
    return self;
}

#pragma mark - Add task

- (void)addTask:(MTask *)task{
    NSAssert(_running == NO,@"Cannot add task when running!");
    [self.tasks addObject:task];
}

- (void)addTaskWithTid:(NSInteger)tid url:(NSString *)url target:(id)target{
    MTask *task = [MTask taskWithTid:tid url:url target:target];
    [self addTask:task];
}

- (void)setTaskBlock:(void (^)(MTask *task))blcok{
    _taskBlock = blcok;
}

- (void)setTaskPauseBlock:(void (^)(MTask *))block{
    _taskPauseBlock = block;
}

#pragma mark - Run

- (void)run{
    if (_running) {
        return;
    }
    _paused = NO;
    _running = YES;
    _taskIndex = 0;
    _runningTaskCount = 0;
    _taskCount = [self.tasks count];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskCompleted) name:kNotificationTaskCompleted object:nil];
    
    for (int i = 0; i < _taskCount - _runningTaskCount; i++) { 
        [self runNextTask];
    }
}

- (void)runNextTask{
    if (_paused) return;
    if(_runningTaskCount < _maxConcurrent && _taskIndex < _taskCount){
        _runningTaskCount++;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self runTaskAtIndex:_taskIndex++];
        });
    }
}

- (void)runTaskAtIndex:(NSInteger)index{
    MTask *task = [self.tasks objectAtIndex:index];
#ifdef DEBUG
    NSLog(@"%ld/%ld %@",(long)index, (long)_taskCount,task.url);
#endif
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        _taskBlock(task);
    });
}

- (void)taskCompleted{
    if (_taskIndex == _taskCount - 1) {
        _running = NO;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    _runningTaskCount--;
    [self runNextTask];
}

- (void)pause{
    _paused = YES;
    if (_taskPauseBlock != NULL) {        
        MTask *task = [self.tasks objectAtIndex:_taskIndex];
        _taskPauseBlock(task);
    }
}

- (void)resume{
    _paused = NO;
    for (int i = 0; i < _taskCount - _runningTaskCount; i++) { 
        [self runNextTask];
    }
}

- (void)abort{
    [self pause];
    _running = NO;
    _taskIndex = 0;
    _runningTaskCount = 0;
}

- (void)reset{
    [self abort];
    [self.tasks removeAllObjects];
}

@end
