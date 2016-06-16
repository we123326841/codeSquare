//
//  WebImageView.h
//  MobiBottle
//
//  Created by LYL on 12/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WebImageViewDelegate;

typedef enum {
   WebImageViewAnimationNone = -1,
    WebImageViewAnimationFade = 1,
    WebImageViewAnimationFlip = 2,
} WebImageViewAnimation;

@interface WebImageView : UIControl {
    NSMutableArray *_cacheList;
    long long _expectedLength;
}
@property (assign, nonatomic) id<WebImageViewDelegate> delegate;
@property (strong, nonatomic) UIImageView *imageView;
@property (assign, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *placeHolder;
@property (strong, nonatomic) UIImageView *background;
@property (assign, nonatomic) UIImage *backgroundImage;
@property (assign, nonatomic) CGPoint backgroundOffset;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *cacheDir;
@property (nonatomic) BOOL caches;
@property (nonatomic) BOOL loading;
@property (nonatomic) BOOL autoLoading;
@property (assign, nonatomic) WebImageViewAnimation animation;

+ (void)clearCaches;
+ (void)clearCachesOfDir:(NSString *)dir;
+ (UIImage *)cacheImageForUrl:(NSString *)url ofDir:(NSString *)dir;
+ (UIImage *)imageForUrl:(NSString *)url;

- (id)initWithImage:(UIImage *)image;

- (id)initWithPlaceHolder:(UIImage *)image;

- (void)startLoading;

- (void)cancelLoading;

@end

@protocol WebImageViewDelegate <NSObject>
- (void)imageViewDidFinishLoading:(WebImageView *)imageView;
@optional
- (void)imageViewDidUpdateProgress:(float)progress;
@end
