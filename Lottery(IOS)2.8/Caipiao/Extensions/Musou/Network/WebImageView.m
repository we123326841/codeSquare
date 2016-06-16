//
//  WebImageView.m
//  MobiBottle
//
//  Created by LYL on 12/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebImageView.h"
#import <QuartzCore/QuartzCore.h>

#define kImageCacheFile @"WebImageCaches.db"

static int _activityCounter = 0;


@interface WebImageView () <NSURLConnectionDelegate>
@property (retain,nonatomic) NSMutableData *recvData;
@property (retain,nonatomic) NSURLConnection *conn;
@end

@implementation WebImageView
@synthesize delegate = _delegate;
@synthesize imageView = _imageView;
@synthesize image = _image;
@synthesize placeHolder = _placeHolder;
@synthesize background = _background;
@synthesize backgroundImage = _backgroundImage;
@synthesize backgroundOffset = _backgroundOffset;
@synthesize url = _url;
@synthesize caches = _caches;
@synthesize cacheDir = _cacheDir;
@synthesize loading = _loading;
@synthesize autoLoading = _autoLoading;
@synthesize animation = _animation;

@synthesize recvData = _recvData;
@synthesize conn = _conn;

- (void)dealloc{
    self.recvData = nil;
    self.conn = nil;
    
    [_imageView release];
    [_placeHolder release];
    [_background release];
    [_url release];
    [_cacheDir release];
    
    [super dealloc];
}

#pragma mark - Helper methods

+ (NSString *)cacheDirForName:(NSString *)dirName{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    if (dirName == nil) {
        return path;
    }
    NSString *dir = [path stringByAppendingPathComponent:dirName];    //@"WebImages"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dir]) {
        NSError *err = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:NO attributes:nil error:&err];
        if (err) {
            NSLog(@"!!!!!%@",err);
        }
    }
    return dir;
}

+ (void)clearCaches{
    [self clearCachesOfDir:@"WebImages"];
}

+ (void)clearCachesOfDir:(NSString *)dir{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:dir];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
    for (NSString *f in files){
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",path,f] error: nil];
    }
}

+ (NSString *)cacheNameForUrl:(NSString *)url{
    if ([url length] < 7) {
        return nil;
    }
    url = [url substringFromIndex:7];    //Remove http://
    NSRange range = [url rangeOfString:@"/"];
    if (range.length < 1) {
        return nil;
    }
    NSString *fileName = [url substringFromIndex:range.location];   //Remove domain
    fileName = [fileName stringByReplacingOccurrencesOfString:@"/|\\?|\\*" withString:@"-" options:NSRegularExpressionSearch range:NSMakeRange(0, fileName.length)];
    return fileName;
}

+ (NSString *)thumbnailCacheNameForUrl:(NSString *)url{
    NSString *fileName = [[self class] cacheNameForUrl:url];
    NSString *extension = [fileName pathExtension];
    fileName = [fileName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", extension]
                                                   withString:[NSString stringWithFormat:@"_thumb.%@",extension]];
    return fileName;
}

+ (UIImage *)cacheImageForUrl:(NSString *)url ofDir:(NSString *)dir{
    NSString *file = [WebImageView cacheNameForUrl:url];
    NSString *path = [WebImageView cacheDirForName:dir];
    path = [path stringByAppendingPathComponent:file];
    return [UIImage imageWithContentsOfFile:path];    
}

+ (UIImage *)imageForUrl:(NSString *)url{
    return [self cacheImageForUrl:url ofDir:@"WebImages"];
}

#pragma mark -

//Create cache db file
- (void)setupCaches{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cacheFile = [path stringByAppendingPathComponent:kImageCacheFile];
    _cacheList = [[NSMutableArray alloc] initWithContentsOfFile:cacheFile];
    if (_cacheList == nil) {
        _cacheList = [[NSMutableArray alloc] init];
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    }
}
//Add cache record to cache db
- (void)addToCache{
    NSString *title = [[self class] cacheNameForUrl:self.url];
    NSString *date = [[NSString stringWithFormat:@"%@",[NSDate date]] substringToIndex:10];
    NSDictionary *row = [NSDictionary dictionaryWithObject:date forKey:title];
    [_cacheList addObject:row];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cacheFile = [path stringByAppendingPathComponent:kImageCacheFile];
    [_cacheList writeToFile:cacheFile atomically:YES];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){

        self.autoLoading = YES;
        self.caches = YES;
        self.cacheDir = @"WebImages";
        _background = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_background];
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageView];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image{
    CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self = [self initWithFrame:frame];
    if (self) {
        self.image = image;
    }
    return self;
}

- (id)initWithPlaceHolder:(UIImage *)image{
    self = [self initWithImage:image];
    if (image) {
        self.placeHolder = image;
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.backgroundImage = self.backgroundImage;
}

- (void)setImage:(UIImage *)image{
    if (image == nil) {
        self.imageView.image = self.placeHolder;
    } else {
        if (self.animation == WebImageViewAnimationFade) {
            
            CATransition *t = [CATransition animation];
            t.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            t.type = kCATransitionFade;
            t.duration = .4f;
            [self.layer addAnimation:t forKey:@"Fade"];
        }
        else if(self.animation == WebImageViewAnimationFlip){
            
            [UIView transitionWithView:self
                              duration:.5f
                               options:UIViewAnimationOptionTransitionFlipFromRight|UIViewAnimationOptionCurveEaseOut
                            animations:NULL
                            completion:NULL];
        }
        self.imageView.image = image;
    }
}

- (UIImage *)image{
    return self.imageView.image;
}

- (void)setContentMode:(UIViewContentMode)contentMode{
    self.imageView.contentMode = contentMode;
    [super setContentMode:contentMode];
}
#define kBackgroundPadding 10.f
- (void)setBackgroundImage:(UIImage *)backgroundImage{
    self.background.image = backgroundImage;
//    self.background.frame = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
    self.background.frame = CGRectMake(0, 0, self.bounds.size.width + kBackgroundPadding*2, self.bounds.size.height + kBackgroundPadding*2);
    self.background.center = CGPointMake(self.backgroundOffset.x +  self.frame.size.width/2, 
                                         self.backgroundOffset.y + self.frame.size.height/2);
}

- (UIImage *)backgroundImage{
    return self.background.image;
}

- (NSString *)cacheName{
    return [[self class] cacheNameForUrl:self.url];
}

- (void)setUrl:(NSString *)url{
    if (_url != url) {
        [self cancelLoading];
        [_url release];
        _url = [url copy];
        if (self.placeHolder) {
            self.image = self.placeHolder;
        }
        [self setNeedsLayout];
    }
}

- (void)startLoading{
    if(self.url == nil || self.loading) return;
    
    self.loading = NO;
    NSString *fileName = [self cacheName];
    NSString *path = [WebImageView cacheDirForName:self.cacheDir];
    path = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        self.image = [UIImage imageWithContentsOfFile:path];
        if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewDidFinishLoading:)]) {
            [self.delegate imageViewDidFinishLoading:self];
        }
    } else {
        NSURL *URL = [NSURL URLWithString:_url];
        NSURLRequest *req = [NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:120.f];
        self.conn = [NSURLConnection connectionWithRequest:req delegate:self];
        self.loading = YES;
    }
}


- (void)cancelLoading{
    if (self.loading) {
        _activityCounter--;
        [self.conn cancel];
         self.loading = NO;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:_activityCounter > 0];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.placeHolder) {
        self.image = self.placeHolder;
    }
    if (self.autoLoading && self.url != nil) {
        [self startLoading];
    }
}


#pragma mark - Touches
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    if (self.target && self.selector) {
//        NSMethodSignature *sign = [self.target methodSignatureForSelector:self.selector];
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sign];
//        [invocation setTarget:self.target];
//        [invocation setSelector:self.selector];
//        id ptr = self;
//        [invocation setArgument:&ptr atIndex:2];
//        [invocation invoke];
//    }
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    _activityCounter--;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:_activityCounter > 0];
#ifdef DEBUG
    NSLog(@"%@",error.description);
#endif
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    _activityCounter++;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.loading = YES;
    self.recvData = [NSMutableData data];
    _expectedLength = [response expectedContentLength];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.recvData appendData:data];
    float progress = [self.recvData length]*1.f/_expectedLength;
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewDidUpdateProgress:)]) {
        [self.delegate imageViewDidUpdateProgress:progress];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    _activityCounter--;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:_activityCounter > 0];
    
    NSString *filename = [self cacheName];
    NSString *dir = [WebImageView cacheDirForName:self.cacheDir];
    NSString *file = [dir stringByAppendingPathComponent:filename];
    [self.recvData writeToFile:file atomically:YES];
    UIImage *image = [UIImage imageWithData:self.recvData];
    self.image = image;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewDidFinishLoading:)]) {
        [self.delegate imageViewDidFinishLoading:self];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewDidUpdateProgress:)]) {
        [self.delegate imageViewDidUpdateProgress:1.f];
    }
    
    
    if (self.caches) {
        if (_expectedLength != [self.recvData length]) {
            return;
        }
        //Save to disk
        __block NSData * data = nil;
        if ([[[file pathExtension] uppercaseString] isEqualToString:@"PNG"]) {
            data = self.recvData;
        } else {
            data = UIImageJPEGRepresentation(self.image, .8f);
        }
        [data retain];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
            [data writeToFile:file atomically:YES];
            [data release];
            data = nil;
        });
    }
    
    self.conn = nil;
    self.recvData = nil;
    self.loading = NO;
}

@end
