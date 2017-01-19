//
//  OFSNSOAuthLogin.m
//  OFSNSTool
//
//  Created by MikeZhangpy on 16/3/14.
//  Copyright © 2016年 MikeZhangpy. All rights reserved.
//

#import "OFSNSOAuthManager.h"

@implementation OFSNSOAuthManager

+ (void)loginWithPlatform:(OFSNSPlatType)platform completionHandle:(void (^)(NSDictionary *, NSError *))completionHandler
{
    if (platform == OFSNSPlatFromWeiXin) {
        [OpenShare WeixinAuth:@"snsapi_userinfo" Success:^(NSDictionary *message) {
            [OFSNSOAuthManager weixinOAuthWithMessage:message completionHandle:completionHandler];
        } Fail:^(NSDictionary *message, NSError *error) {
            if (completionHandler) {
                completionHandler(message, error);
            }
        }];
        
    } else if (platform == OFSNSPlatFromQQ) {
        [OpenShare QQAuth:@"all" Success:^(NSDictionary *message) {
            [OFSNSOAuthManager qqOAuthWithMessage:message completionHandle:completionHandler];
        } Fail:^(NSDictionary *message, NSError *error) {
            if (completionHandler) {
                completionHandler(message, error);
            }
        }];
    } else if (platform == OFSNSPlatFromWeibo) {
        NSString *redirectURI = [[NSUserDefaults standardUserDefaults] objectForKey:kSNSPlatWeiboRedirectURIKey];
        [OpenShare WeiboAuth:@"all" redirectURI:redirectURI Success:^(NSDictionary *message) {
            [OFSNSOAuthManager weiboOAuthWithMessage:message completionHandle:completionHandler];
        } Fail:^(NSDictionary *message, NSError *error) {
            if (completionHandler) {
                completionHandler(message, error);
            }
        }];
        

    }

}

+ (void)weixinOAuthWithMessage:(NSDictionary *)message completionHandle:(void (^)(NSDictionary *, NSError *))completionHandler
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *appId = [ud objectForKey:kSNSPlatWeixinKey];
    NSString *secret = [ud objectForKey:kSNSPlatWeixinSecretKey];
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", appId, secret, message[@"code"]];
    [OFSNSRequest get:url completionHandler:^(NSDictionary *data, NSError *error) {
        NSString *accessToken = data[@"access_token"];
        NSString *openid = data[@"openid"];
        
        NSString *userInfoUrl = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@&lang=zh_CN", accessToken, openid];
        [OFSNSRequest get:userInfoUrl completionHandler:^(NSDictionary *userInfo, NSError *error) {
            NSMutableDictionary *dict = userInfo.mutableCopy;
            [dict addEntriesFromDictionary:message];
            if (completionHandler) {
                completionHandler(dict, error);
            }
        }];
    }];
}

+ (void)weiboOAuthWithMessage:(NSDictionary *)message completionHandle:(void (^)(NSDictionary *, NSError *))completionHandler
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    NSDictionary *params = @{@"source": [ud objectForKey:kSNSPlatWeiboKey],
                             @"access_token": message[@"accessToken"],
                             @"uid": message[@"userID"]};
    [OFSNSRequest get:url params:params completionHandler:^(NSDictionary *data, NSError *error) {
        NSMutableDictionary *dict = data.mutableCopy;
        [dict addEntriesFromDictionary:message];
        if (completionHandler) {
            completionHandler(dict, error);
        }
    }];
}

+ (void)qqOAuthWithMessage:(NSDictionary *)message completionHandle:(void (^)(NSDictionary *, NSError *))completionHandler
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *url = @"http://openapi.tencentyun.com/v3/user/get_info";
    NSMutableDictionary *params = @{@"appid": [ud objectForKey:kSNSPlatQQKey],
                                    @"openkey": message[@"access_token"],
                                    @"openid": message[@"openid"],
                                    @"pf": @"qzone",
                                    @"format": @"json"}.mutableCopy;
    NSMutableString *paramsString = [NSString stringWithFormat:@"GET&%@&", [@"/v3/user/get_info" encodeURL]].mutableCopy;
    NSArray *keys = @[@"appid", @"format", @"openid", @"openkey", @"pf"];
    NSMutableString *keyValueString = @"".mutableCopy;
    for (NSString *key in keys) {
        [keyValueString appendFormat:@"%@=%@&", key, params[key]];
    }
    [keyValueString appendString:@"userip="];
    keyValueString = [keyValueString encodeURL].mutableCopy;
    [keyValueString appendString:@"10.0.0.1"];
    NSString *signStr = [NSString stringWithFormat:@"%@%@", paramsString, keyValueString];
    NSString *sss = [signStr hmacSha1WithKey:[NSString stringWithFormat:@"%@&", [ud objectForKey:kSNSPlatQQSecretKey]]];
    NSString *sig = [sss encodeURL];
    params[@"sig"] = sig;
    params[@"userip"] = @"10.0.0.1";
    
    NSMutableString *urlString = @"?".mutableCopy;
    for (NSString *key in params.allKeys) {
        [urlString appendFormat:@"%@=%@&", key, params[key]];
    }
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", url, urlString];
    requestUrl = [requestUrl substringToIndex:requestUrl.length - 1];
    
    [OFSNSRequest get:requestUrl completionHandler:^(NSDictionary *data, NSError *error) {
        NSMutableDictionary *dict = data.mutableCopy;
        [dict addEntriesFromDictionary:message];
        if (completionHandler) {
            completionHandler(dict, error);
        }
    }];
}


@end
