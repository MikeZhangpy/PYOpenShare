//
//  NSString+SNSExtenion.h
//  OFSNSTool
//
//  Created by MikeZhangpy on 16/3/14.
//  Copyright © 2016年 MikeZhangpy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SNSExtenion)

/// 将字符串进行Url编码
- (NSString *)encodeURL;

/// 将字符串进行Hash
- (NSString *)hmacSha1WithKey:(NSString *)key;
@end
