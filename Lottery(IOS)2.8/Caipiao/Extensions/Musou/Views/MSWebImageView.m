//
//  MSWebImageView.m
//  
//
//  Created by danal.luo on 2/27/14.
//  Copyright (c) 2014 danal. All rights reserved.
//
//  Support Http image and GIF image
//

#import <ImageIO/ImageIO.h>
#import <QuartzCore/CoreAnimation.h>

#import "MSWebImageView.h"
#import "MSDownloader.h"



@interface MSWebImageView ()<MSDownloaderDelegate>
@property (strong, nonatomic) MSDownloader *loader;
@property (strong, nonatomic) NSString *webUrl;
@property (assign, nonatomic) id target;
@property (nonatomic) SEL action;
@property (nonatomic) BOOL playing;
@property (nonatomic) BOOL paused;
@end

@implementation MSWebImageView

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"%s",__func__);
#endif
    [_loader stop];
#if !__has_feature(objc_arc)
    [_loader release];
    [_webUrl release];
    [super dealloc];
#endif
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        _autoLoading = YES;
        _autoPlayGif = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _autoLoading = YES;
        _autoPlayGif = YES;
    }
    return self;
}

- (void)setUrl:(NSString *)url{
    self.webUrl = url;
    if (_autoLoading){
        [self stopLoading];
        [self startLoading];
    }
}

- (NSString *)url{
    return self.webUrl;
}

- (void)fillData:(NSData *)data{
    if (IsGifImage(data)){
        _isGif = YES;
        [self playGif:data];
    } else {
        UIImage *img = [[UIImage alloc] initWithData:data];
        self.image = img;
        [img release];
    }
}

#define DOWNLOAD_QUEUE dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

- (void)startLoading{
    if (_loading) return;
    
    _isGif = NO;
    _playing = NO;
    _loading = YES;
    
    if ([MSDownloader dataHasDownloaded:self.url]){
        _loading = NO;
        self.loader = nil;
        @autoreleasepool {
            
            NSData *data = [MSDownloader downloadedData:self.url];
            if (IsGifImage(data)){
                _isGif = YES;
                if (_autoPlayGif){
                    [self playGif:data];
                } else {
                    NSString *file = [[self class] GifPreviewPath:[MSDownloader cachedFilePath:self.url]];
                    UIImage *img = [[UIImage alloc] initWithContentsOfFile:file];
                    self.image = img;
                    [img release];
                }
                [self onLoadingFinish];
            } else {
                UIImage *img = [[UIImage alloc] initWithData:data];
                self.image = img;
                [self onLoadingFinish];
                [img release];
            }
        }
    }
    else {      //Launch a new downloading
        
        MSDownloader *dl = [[MSDownloader alloc] initWithUrl:self.url];
        self.loader = dl;
        _loader.delegate = self;
        [_loader start];
        [dl release];
    }
    
}

- (void)stopLoading{
    _loader.delegate = nil;
    [_loader stop];
    _loading = NO;
}

- (void)onLoadingFinish{
    _loading = NO;
    if (_animation == MSWebImageViewAnimationFade) {
        
        CATransition *t = [CATransition animation];
        t.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        t.type = kCATransitionFade;
        t.duration = .4f;
        [self.layer addAnimation:t forKey:@"Fade"];
    }
    else if(_animation == MSWebImageViewAnimationFlip){
        
        [UIView transitionWithView:self
                          duration:.5f
                           options:UIViewAnimationOptionTransitionFlipFromRight|UIViewAnimationOptionCurveEaseOut
                        animations:NULL
                        completion:NULL];
    }
    
}

- (void)handleTouches{
    [_target performSelector:_action withObject:self];
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)events{
    _target = target;
    _action = action;
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouches)];
    [self addGestureRecognizer:g];
    [g release];
}

- (BOOL)isGif{
    return _isGif;
}

- (CGSize)imageSize{
    return _imageSize;
}

- (NSData *)imageData{
    if (_isGif){
        return [MSDownloader downloadedData:self.url];
    } else {
        return UIImageJPEGRepresentation(self.image, .9f);
    }
}

+ (NSString *)GifPreviewPath:(NSString *)gifPath{
    return [gifPath stringByAppendingString:@"0"];
}

+ (NSData *)downloadedImageData:(NSString *)url{
    return [MSDownloader downloadedData:url];
}

#pragma mark - Gif support
/*
 * @brief resolving gif information
 */
void GetFrameInfo(CFDataRef data, NSMutableArray *frames, NSMutableArray *delayTimes, CGFloat *totalTime,CGFloat *gifWidth, CGFloat *gifHeight)
{
    CGImageSourceRef gifSource = CGImageSourceCreateWithData(data, NULL);
    //CGImageSourceCreateWithURL(url, NULL);
    // get frame count
    size_t frameCount = CGImageSourceGetCount(gifSource);
    for (size_t i = 0; i < frameCount; ++i) {
        // get each frame
        CGImageRef frame = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        [frames addObject:(id)frame];
        CGImageRelease(frame);
        
        // get gif info with each frame
        NSDictionary *dict = (NSDictionary*)CGImageSourceCopyPropertiesAtIndex(gifSource, i, NULL);
        // get gif size
        if (gifWidth != NULL && gifHeight != NULL) {
            *gifWidth = [[dict valueForKey:(NSString*)kCGImagePropertyPixelWidth] floatValue];
            *gifHeight = [[dict valueForKey:(NSString*)kCGImagePropertyPixelHeight] floatValue];
        }
        
        // kCGImagePropertyGIFDictionary中kCGImagePropertyGIFDelayTime，kCGImagePropertyGIFUnclampedDelayTime值是一样的
        NSDictionary *gifDict = [dict valueForKey:(NSString*)kCGImagePropertyGIFDictionary];
        [delayTimes addObject:[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime]];
        
        if (totalTime) {
            *totalTime = *totalTime + [[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime] floatValue];
        }
        CFRelease(dict);
    }
    CFRelease(gifSource);
}

UIImage* GetGIFPreviewRetain(CFDataRef data){
    CGImageSourceRef gif = CGImageSourceCreateWithData(data, NULL);
    CGImageRef frame = CGImageSourceCreateImageAtIndex(gif, 0, NULL);
    UIImage *img = [[UIImage alloc] initWithCGImage:frame];
    CFRelease(gif);
    CGImageRelease(frame);
    return img;
}

BOOL IsGifImage(NSData* imageData) {
	const char* buf = (const char*)[imageData bytes];
	if (buf[0] == 0x47 && buf[1] == 0x49 && buf[2] == 0x46 && buf[3] == 0x38) {
		return YES;
	}
	return NO;
}

- (BOOL)playGif:(NSData *)gifData{
    if (!IsGifImage(gifData)) return NO;
    
    CGFloat _totalTime = 0.f;
    CGFloat _gifWidth, _gifHeight;
    NSMutableArray *_frameDelayTimes = [[NSMutableArray alloc] init];
    NSMutableArray *_frames = [[NSMutableArray alloc] init];
    GetFrameInfo((CFDataRef)gifData, _frames, _frameDelayTimes, &_totalTime, &_gifWidth, &_gifHeight);
    _imageSize = CGSizeMake(_gifWidth, _gifHeight);
    
    NSMutableArray *_images = [[NSMutableArray alloc] init];
    for (id obj in _frames){
        CGImageRef ref = (CGImageRef)obj;
        UIImage *img = [[UIImage alloc] initWithCGImage:ref];
        [_images addObject:img];
        [img release];
    }
    self.animationImages = _images;
    self.animationDuration = _totalTime;
    [self startAnimating];
    [_images release];
    [_frames release];
    [_frameDelayTimes release];
    
    /* //这种方法在layer暂停动画的时候可能会被移除
     CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
     
     NSMutableArray *times = [NSMutableArray arrayWithCapacity:3];
     CGFloat currentTime = 0;
     int count = _frameDelayTimes.count;
     for (int i = 0; i < count; ++i) {
     [times addObject:[NSNumber numberWithFloat:(currentTime / _totalTime)]];
     currentTime += [[_frameDelayTimes objectAtIndex:i] floatValue];
     }
     [animation setKeyTimes:times];
     
     NSMutableArray *images = [NSMutableArray arrayWithCapacity:3];
     for (int i = 0; i < count; ++i) {
     [images addObject:[_frames objectAtIndex:i]];
     }
     
     [animation setValues:images];
     animation.duration = _totalTime;
     animation.delegate = self;
     animation.repeatCount = 1e6;
     
     [self.layer addAnimation:animation forKey:@"gif"];
     */
    return YES;
}

- (void)playGif{
    if(_isGif && !_playing){
        NSData *data = [MSDownloader downloadedData:self.url];
        [self playGif:data];
        _playing = YES;
    }
}

- (void)resumePlay{
    if (!_playing && _isGif) {
        [self playGif];
        return;
    }
    if (!_paused) return;
    _paused = NO;
    
    CALayer *layer = self.layer;
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

- (void)pausePlay{
    if (_paused) return;
    _paused = YES;
    
    CALayer *layer = self.layer;
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

#pragma mark - Downloader Delegate

- (void)onDownloaderFinish:(MSDownloader *)dl error:(NSError *)error{
    _isGif = NO;
    if (error){
        NSLog(@"%@",error);
    } else {
        if ([self playGif:dl.data]){
            _isGif = YES;
            //Save the 1st frame as a preview
            dispatch_async(DOWNLOAD_QUEUE, ^{
                @autoreleasepool {
                    UIImage *preview = GetGIFPreviewRetain((CFDataRef)dl.data);
                    NSData *data = UIImageJPEGRepresentation(preview, .8f);
                    NSString *file = [[self class] GifPreviewPath:[dl cachedFilePath]];
                    [data writeToFile:file atomically:YES];
                    [preview release];
                }
            });
            
        } else {
            UIImage *img = [[UIImage alloc] initWithData:dl.data];
            if (img)
                self.image = img;
            [img release];
            _imageSize = self.image.size;
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(onImageLoaded:error:)]){
        [_delegate onImageLoaded:self error:error];
    }
    [self onLoadingFinish];
    self.loader = nil;
    _loading = NO;
}

- (void)onDownloaderUpdateProgress:(MSDownloader *)dl progress:(float)progress{
    if (_delegate && [_delegate respondsToSelector:@selector(onImageLoadingProgressUpdate:progress:)]){
        [_delegate onImageLoadingProgressUpdate:self progress:progress];
    }
}

@end
