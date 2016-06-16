//
//  UIImage+Additiions.h
//  Community
//
//  Created by luo danal on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Musou)

+ (UIImage *)imageWithResFile:(NSString *)file;

- (UIImage *)clipsToRect:(CGRect)rect;

- (UIImage *)resizeToSize:(CGSize)newSize;

- (void)saveToCachesAsJPG:(NSString *)fileName;

- (UIImage *)PNG2JPG;

- (UIImage *)scaleByFactor:(float)scaleBy;

- (UIImage *)resizableImageWithLeftCap:(CGFloat)dx topCap:(CGFloat)dy width:(CGFloat)w height:(CGFloat)h;

/*
 * Filtering
 */
- (UIImage *)sepia;
- (UIImage *)grayscale;
- (UIImage *)negative;


@end
