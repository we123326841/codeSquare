//
//  MSWebImageView.h
//  
//
//  Created by danal.luo on 2/27/14.
//  Copyright (c) 2014 danal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MSWebImageViewAnimationNone = 0,
    MSWebImageViewAnimationFade = 1,
    MSWebImageViewAnimationFlip = 2,
} MSWebImageViewAnimation;

@protocol MSWebImageViewDelegate;

@interface MSWebImageView : UIImageView
{
    BOOL _isGif;
    CGSize _imageSize;
}
@property (assign, nonatomic) id<MSWebImageViewDelegate> delegate;
@property (strong, nonatomic) NSString *url;
@property (nonatomic) BOOL autoLoading;
@property (nonatomic) BOOL autoPlayGif;
@property (nonatomic) BOOL loading;
@property (assign, nonatomic) MSWebImageViewAnimation animation;

- (void)startLoading;
- (void)stopLoading;
- (void)onLoadingFinish;
- (void)playGif;
- (void)resumePlay;
- (void)pausePlay;
- (BOOL)isGif;

- (void)fillData:(NSData *)data;

- (CGSize)imageSize;
- (NSData *)imageData;

//Only support UIControlEventTouchUpInside now
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)events;

+ (NSData *)downloadedImageData:(NSString *)url;

@end


@protocol MSWebImageViewDelegate <NSObject>
@optional
- (void)onImageLoaded:(MSWebImageView *)imageView error:(NSError *)error;
- (void)onImageLoadingProgressUpdate:(MSWebImageView *)imageView progress:(float)progress;
@end