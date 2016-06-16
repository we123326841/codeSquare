//
//  MSDownloader.h
//  VGirl
//
//  Created by danal.luo on 2/26/14.
//  Copyright (c) 2014 danal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSDownloaderDelegate;
@interface MSDownloader : NSObject
@property (assign, nonatomic) id<MSDownloaderDelegate> delegate;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *cachename;
@property (assign, nonatomic) NSInteger mark;
@property (nonatomic) BOOL loading;


- (id)initWithUrl:(NSString *)httpUrl;

- (void)start;
- (void)stop;

/**
 * The Received data
 */
- (NSData *)data;

/**
 * The cached file path
 */
- (NSString *)cachedFilePath;

/**
 * @param httpUrl The url to request
 * @return the data if has downloaded, else nil
 */
+ (BOOL)dataHasDownloaded:(NSString *)httpUrl;
+ (NSData *)downloadedData:(NSString *)httpUrl;
+ (NSString *)cachedFilePath:(NSString *)httpUrl;

/**
 * Clear the downloaded data
 */
+ (void)clearCaches:(void(^)(void))complete;

@end

@protocol MSDownloaderDelegate <NSObject>
@optional
- (void)onDownloaderStart:(MSDownloader *)dl;
- (void)onDownloaderFinish:(MSDownloader *)dl error:(NSError *)error;
- (void)onDownloaderProgressUpdate:(MSDownloader *)dl progress:(float)progress;
@end