
//
//  KCDES.m
//  DES
//
//  Created by Kevin Chou on 14-2-18.
//  Copyright (c) 2014年 Kevin Chou. All rights reserved.
//

#import "BaseDES.h"
#import "GTMBase64.h"
#include <CommonCrypto/CommonCryptor.h>

@implementation BaseDES
+ (NSString*)decryptUseDES:(NSString*)cipherText key:(NSString*)key
{
    // 利用 GTMBase64 解碼 Base64 字串
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    // IV 偏移量不需使用
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}


+ (NSString *)encryptUseDES:(NSString *)clearText key:(NSString *)key
{
    NSData *data = [clearText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          1024,
                                          &numBytesEncrypted);
    
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        plainText = [GTMBase64 stringByEncodingData:dataTemp];
    }else{
        NSLog(@"DES加密失败");
    }
    return plainText;
}

@end
