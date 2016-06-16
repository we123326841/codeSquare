//
//  UIImage+Additiions.m
//  Community
//
//  Created by luo danal on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSUIImage+Additiions.h"

@implementation UIImage (Musou)

+ (UIImage *)imageWithResFile:(NSString *)file{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:nil]];
}

- (UIImage *)clipsToRect:(CGRect)rect{ 
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, 0, self.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextDrawImage(ctx, CGRectMake(rect.origin.x, rect.origin.y, self.size.width, self.size.height), self.CGImage);
    CGContextClipToRect(ctx, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)resizeToSize:(CGSize)newSize{
    
    UIGraphicsBeginImageContext(newSize);
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, 0, newSize.height);
    CGContextScaleCTM(c, 1, -1);
    CGRect rect = CGRectMake(0, 0, newSize.width, newSize.height);
    CGContextDrawImage(c, rect, self.CGImage);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)saveToCachesAsJPG:(NSString *)fileName{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSData *data = UIImageJPEGRepresentation(self, .8f);
    [data writeToFile:[path stringByAppendingPathComponent:fileName] atomically:YES];
}

- (UIImage *)PNG2JPG{
    NSData *data = UIImageJPEGRepresentation(self, .8f);
    return [UIImage imageWithData:data];
}

- (UIImage *)scaleByFactor:(float)scaleBy
{
    UIImage *image = self;
    CGSize size = CGSizeMake(image.size.width * scaleBy, image.size.height * scaleBy);

    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform transform = CGAffineTransformIdentity;

    transform = CGAffineTransformScale(transform, scaleBy, scaleBy);
    CGContextConcatCTM(context, transform);

    // Draw the image into the transformed context and return the image
    [image drawAtPoint:CGPointMake(0.0f, 0.0f)];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newimg;  
}

- (UIImage *)resizableImageWithLeftCap:(CGFloat)dx topCap:(CGFloat)dy width:(CGFloat)w height:(CGFloat)h{
    UIImage *image = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0f) {
        image = [self stretchableImageWithLeftCapWidth:dx topCapHeight:dy];
    } else {
        image = [self resizableImageWithCapInsets:UIEdgeInsetsMake(dx, dy, self.size.width - dx + w, self.size.height - dy + h)];
    }
    return image;
}

#pragma mark - Filtering

- (UIImage *)sepia {
	CGFloat originalWidth = self.size.width;
	CGFloat originalHeight = self.size.height;
	size_t bytesPerRow = originalWidth * 4;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, originalWidth, originalHeight, 8, bytesPerRow, colorSpace, 
                                                 kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
	CGColorSpaceRelease(colorSpace);
	if (!context) return nil;
    
	// Draw the image in the bitmap context
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, originalWidth, originalHeight), self.CGImage);
    
	/// Grab the image raw data
	UInt8 *data = (UInt8 *)CGBitmapContextGetData(context);
	if (!data) {
		CGContextRelease(context);
		return nil;
	}
    
	const size_t bitmapByteCount = bytesPerRow * originalHeight;
	for (size_t i = 0; i < bitmapByteCount; i += 4) {
		UInt8 r = data[i + 1];
		UInt8 g = data[i + 2];
		UInt8 b = data[i + 3];
        
		NSInteger newRed = (r * 0.393) + (g * 0.769) + (b * 0.189);
		NSInteger newGreen = (r * 0.349) + (g * 0.686) + (b * 0.168);
		NSInteger newBlue = (r * 0.272) + (g * 0.534) + (b * 0.131);
        
		if (newRed > 255) newRed = 255;
		if (newGreen > 255) newGreen = 255;
		if (newBlue > 255) newBlue = 255;
        
		data[i + 1] = (UInt8)newRed;
		data[i + 2] = (UInt8)newGreen;
		data[i + 3] = (UInt8)newBlue;
	}
    
	CGImageRef sepiaImageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
	UIImage *sepiaImage = [UIImage imageWithCGImage:sepiaImageRef];
	CGImageRelease(sepiaImageRef);
    
	return sepiaImage;
}

- (UIImage *)grayscale {
	CGFloat originalWidth = self.size.width;
	CGFloat originalHeight = self.size.height;
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
	CGContextRef context = CGBitmapContextCreate(NULL, originalWidth, originalHeight, 8, 3 * originalWidth, colorSpace, kCGImageAlphaNone);
	CGColorSpaceRelease(colorSpace);
	if (!context) return nil;
    
    
	// Image quality
	CGContextSetShouldAntialias(context, false);
	CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
	// Draw the image in the bitmap context
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, originalWidth, originalHeight), self.CGImage);
    
	// Create an image object from the context
	CGImageRef grayscaleImageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
	UIImage *grayscaleImage = [UIImage imageWithCGImage:grayscaleImageRef];
	CGImageRelease(grayscaleImageRef);
    
	return grayscaleImage;
}

// by http://www.sixtemia.com/journal/2010/06/23/uiimage-negative-color-effect/
- (UIImage *)negative {
    UIGraphicsBeginImageContext(self.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    [self drawInRect:CGRectMake(0.0, 0.0, self.size.width, self.size.height)];
    
    CGContextSetBlendMode(context, kCGBlendModeDifference);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGContextFillRect(context, CGRectMake(0.0, 0.0, self.size.width, self.size.height));
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}

@end
