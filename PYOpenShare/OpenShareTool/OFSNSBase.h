//
//  OFSNSBase.h
//  OFSNSTool
//
//  Created by MikeZhangpy on 16/3/14.
//  Copyright © 2016年 MikeZhangpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenShare.h"
#import "OpenShareHeader.h"
#import "OFSNSConst.h"

/**
 *  注册平台信息
 */
@interface OFSNSBase : NSObject

/**
 *  注册微信Api
 *
 *  @param appId  kSNSPlatWeixinKey
 *  @param secret kSNSPlatWeixinSecretKey
 */
+ (void)registerWeiXinAppId:(NSString *)appId secret:(NSString *)secret;
/**
 *  注册腾讯QQApi
 *
 *  @param appId  kSNSPlatQQKey
 *  @param secret kSNSPlatQQSecretKey
 */
+ (void)registerQQAppId:(NSString *)appId secret:(NSString *)secret;
/**
 *  注册新浪微博Api
 *
 *  @param appId       kSNSPlatWeiboKey
 *  @param secret      kSNSPlatWeiboSecretKey
 *  @param redirectURI kSNSPlatWeiboRedirectURIKey
 */
+ (void)registerWeiboAppId:(NSString *)appId secret:(NSString *)secret redirectURI:(NSString *)redirectURI;


@end
