//
//  NSString+DES.m
//  Toon
//
//  Created by wangpo on 2018/4/12.
//  Copyright © 2018年 思源. All rights reserved.
//

#import "NSString+TNDES.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (TNDES)

- (NSString *)DES3EncryptWithKey:(NSString *)key
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];

    // 'key' should be 24 bytes for DES, will be null-padded otherwise
    char keyPtr[kCCKeySize3DES+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    NSUInteger dataLength = [data length];

    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSize3DES;
    void *buffer = malloc(bufferSize);
    const void * vinitVec = (const void *)[@"01234567" UTF8String];
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithm3DES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCKeySize3DES,
                                          vinitVec /* initialization vector (optional) */,
                                          [data bytes],
                                          dataLength, /* input */
                                          buffer,
                                          bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        NSData *e3Data =  [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        NSString *e3String = [e3Data base64EncodedStringWithOptions:0];
        return e3String;
    }
    free(buffer); //free the buffer;
    return nil;
}


- (NSString *)DES3DecryptWithKey:(NSString *)key
{
    NSData *e3Data = [[NSData alloc] initWithBase64EncodedString:self options:0];

    // 'key' should be 24 bytes for DES, will be null-padded otherwise
    char keyPtr[kCCKeySize3DES+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [e3Data length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSize3DES;
    void *buffer = malloc(bufferSize);
    
    const void * vinitVec = (const void *)[@"01234567" UTF8String];
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithm3DES, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySize3DES,
                                          vinitVec /* initialization vector (optional) */,
                                          [e3Data bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return string;

    }
    free(buffer); //free the buffer;
    return nil;

}

@end
