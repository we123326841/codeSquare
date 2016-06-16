//
//  MSDownloader.m
//  VGirl
//
//  Created by danal.luo on 2/26/14.
//  Copyright (c) 2014 danal. All rights reserved.
//

#import "MSDownloader.h"

#define kDownloadPath [NSString stringWithFormat:@"%@/Library/Caches/Downloads",NSHomeDirectory()]

@interface MSDownloader ()<NSURLConnectionDelegate>
{
    int _activityCounter;
    long long _expectedLength;
}
@property (strong,nonatomic) NSMutableData *recvData;
@property (strong,nonatomic) NSURLConnection *conn;
@end

@implementation MSDownloader

- (void)dealloc{
#if !__has_feature(objc_arc)
    self.recvData = nil;
    self.conn = nil;
    self.url = nil;
    self.cachename = nil;
    [super dealloc];
#endif
}

- (id)init{
    self = [super init];
    if (self){
        if (![[NSFileManager defaultManager] fileExistsAtPath:kDownloadPath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:kDownloadPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return self;
}

- (id)initWithUrl:(NSString *)httpUrl{
    self = [self init];
    if (self){
        self.url = httpUrl;
    }
    return self;
}

- (void)start{
//    NSAssert(_url != nil, @"Url cannot be nil!");
    if (!self.url){
        NSLog(@"-------Url is nil-------");
        return;
    }
    if (self.loading) return;
    
//    NSString *fileName = [self _cacheName];
//    NSString *path = self.cacheDir;
//    path = [path stringByAppendingPathComponent:fileName];
//    NSFileManager *fm = [NSFileManager defaultManager];
//    if ([fm fileExistsAtPath:path]) {
//        self.image = [UIImage imageWithContentsOfFile:path];
//        if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewDidFinishLoading:)]) {
//            [self.delegate imageViewDidFinishLoading:self];
//        }
//    } else {

        NSURL *URL = [NSURL URLWithString:_url];
        NSURLRequest *req = [NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:120.f];
        self.conn = [NSURLConnection connectionWithRequest:req delegate:self];
        self.loading = YES;
    
    if (_delegate && [_delegate respondsToSelector:@selector(onDownloaderStart:)]){
        [_delegate onDownloaderStart:self];
    }
}

- (void)stop{
    [self.conn cancel];
    self.conn = nil;
    self.recvData = nil;
}

- (NSData *)data{
    return _recvData;
}

- (NSString *)cachedFilePath{
    return [self _fullCacheName];
}

- (NSString *)_cacheName{
    return _cachename != nil ? _cachename : [[self class] cacheNameForUrl:self.url];
}

- (NSString *)_fullCacheName{
    return [NSString stringWithFormat:@"%@/%@",kDownloadPath,[self _cacheName]];
}

#pragma mark - NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    _activityCounter--;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:_activityCounter > 0];
    if (_delegate){
        [_delegate onDownloaderFinish:self error:error];
    }
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
    if (_delegate && [_delegate respondsToSelector:@selector(onDownloaderProgressUpdate:progress:)]) {
        [_delegate onDownloaderProgressUpdate:self progress:progress];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    _activityCounter--;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:_activityCounter > 0];
    
    NSString *file = [self _fullCacheName];
    [self.recvData writeToFile:file atomically:YES];
    
    if (_delegate){
        [_delegate onDownloaderFinish:self error:nil];
    }
    
    self.conn = nil;
    self.recvData = nil;
    self.loading = NO;
    
}

#pragma mark -
+ (void)clearCaches:(void (^)(void))complete{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSString *path = kDownloadPath;
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray *subpaths = [fm subpathsAtPath:path];
        for (NSString *f in subpaths) {
            [fm removeItemAtPath:[path stringByAppendingPathComponent:f] error:nil];
        }
        dispatch_sync(dispatch_get_main_queue(), complete);
    });
}

+ (BOOL)dataHasDownloaded:(NSString *)httpUrl{
    NSString *file = [kDownloadPath stringByAppendingFormat:@"/%@",[self cacheNameForUrl:httpUrl]];
    return [[NSFileManager defaultManager] fileExistsAtPath:file];
}

+ (NSData *)downloadedData:(NSString *)httpUrl{
    NSString *file = [kDownloadPath stringByAppendingFormat:@"/%@",[self cacheNameForUrl:httpUrl]];
    return [NSData dataWithContentsOfFile:file];
}

+ (NSString *)cachedFilePath:(NSString *)httpUrl{
    NSString *file = [kDownloadPath stringByAppendingFormat:@"/%@",[self cacheNameForUrl:httpUrl]];
    return file;
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


@end
