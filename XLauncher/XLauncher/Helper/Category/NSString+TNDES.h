//
//  NSString+DES.h
//  Toon
//
//  Created by wangpo on 2018/4/12.
//  Copyright © 2018年 思源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TNDES)

/**
 加密

 @param key 密钥 24个字节

 @return 加密后的字符串
 */
- (NSString *)DES3EncryptWithKey:(NSString *)key;

/**
 解密
 
 @param key 密钥 24个字节
 @return 解密后的字符串
 */
- (NSString *)DES3DecryptWithKey:(NSString *)key;

@end

