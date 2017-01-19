//
//  OFSNSBase.m
//  OFSNSTool
//
//  Created by MikeZhangpy on 16/3/14.
//  Copyright © 2016年 MikeZhangpy. All rights reserved.
//

#import "OFSNSBase.h"

@implementation OFSNSBase

+ (void)registerWeiXinAppId:(NSString *)appId secret:(NSString *)secret {
    
    NSAssert2(appId.length > 0, @"注册微信appId不能为空", __FUNCTION__, __LINE__);
    
    if (appId.length > 0) {
        [OpenShare connectWeixinWithAppId:appId];
    
        [[NSUserDefaults standardUserDefaults] setObject:appId forKey:kSNSPlatWeixinKey];
        
        if (secret.length > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:secret forKey:kSNSPlatWeixinSecretKey];
        } else {
            NSLog(@"微信secretKey为空");
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        NSLog(@"微信appId为空");
    }
}

+ (void)registerQQAppId:(NSString *)appId secret:(NSString *)secret {
    
    NSAssert2(appId.length > 0,@"注册QQappId不能为空", __FUNCTION__, __LINE__);
    
    if (appId.length > 0) {
        [OpenShare connectQQWithAppId:appId];
        
        [[NSUserDefaults standardUserDefaults] setObject:appId forKey:kSNSPlatQQKey];
        
        if (secret.length > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:secret forKey:kSNSPlatQQSecretKey];
        } else {
            NSLog(@"QQsecretKey为空");
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        NSLog(@"QQappId为空");
    }
    
    
}

+ (void)registerWeiboAppId:(NSString *)appId secret:(NSString *)secret redirectURI:(NSString *)redirectURI {
    
    NSAssert2(appId.length > 0,@"注册微博appId不能为空", __FUNCTION__, __LINE__);
    
    if (appId.length > 0) {
        [OpenShare connectWeiboWithAppKey:appId];
        
        [[NSUserDefaults standardUserDefaults] setObject:appId forKey:kSNSPlatWeiboKey];
        
        if (secret.length > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:secret forKey:kSNSPlatWeiboSecretKey];
        } else {
            NSLog(@"微博secretKey为空");
        }
        
        if (redirectURI.length > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:redirectURI forKey:kSNSPlatWeiboRedirectURIKey];
        } else {
            NSLog(@"微博URI为空");
        }
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        NSLog(@"微博appId为空");
    }
}

@end
