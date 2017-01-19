//
//  OFSNSOAuthLogin.h
//  OFSNSTool
//
//  Created by MikeZhangpy on 16/3/14.
//  Copyright © 2016年 MikeZhangpy. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "OFSNSConst.h"
#import "OFSNSRequest.h"
#import "NSString+SNSExtenion.h"
#import "OpenShare.h"
#import "OpenShareHeader.h"

/**
 *  第三方登录管理类
 */
@interface OFSNSOAuthManager : NSObject

/**
 *  登录操作
 *
 *  @param platform          平台类型
 *  @param completionHandler 完成后的代理，成功后会返回用户信息，失败后会返回失败信息
 */
+ (void)loginWithPlatform:(OFSNSPlatType)platform completionHandle:(void (^)(NSDictionary *data, NSError *error))completionHandler;
@end
