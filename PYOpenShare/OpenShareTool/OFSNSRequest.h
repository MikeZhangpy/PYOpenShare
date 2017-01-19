//
//  OFSNSRequest.h
//  OFSNSTool
//
//  Created by MikeZhangpy on 16/3/14.
//  Copyright © 2016年 MikeZhangpy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  请求类，用于获取用户信息
 */
@interface OFSNSRequest : NSObject

+ (void)get:(NSString *)urlPath completionHandler:(void (^)(id data, NSError *error))completionHandler;
+ (void)get:(NSString *)urlPath params:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler;
@end
