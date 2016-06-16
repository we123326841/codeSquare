//
//  MSNSData+Additions.h
//  MusouKit
//
//  Created by danal on 13-4-7.
//  Copyright (c) 2013年 danal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSData (Musou)

- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)base64;
- (NSData*)encryptAES:(NSString *)key;
- (NSData *)encryptRSAWithPublicKey:(SecKeyRef)publicKey maxPlainLen:(size_t)maxPlainLen;

- (NSData *)AES128EncryptWithKey:(NSString *)key AndIV:(NSString *)iv;
- (NSData *)AES128DecryptWithKey:(NSString *)key AndIV:(NSString *)iv;

- (NSString *)hexadecimalString;
+ (id)dataWithHexString:(NSString *)hex;

+ (NSData *)dataWithBase64String:(NSString *)string;
+ (SecKeyRef)getPublicKey:(NSString *)certificatePath;

@end
