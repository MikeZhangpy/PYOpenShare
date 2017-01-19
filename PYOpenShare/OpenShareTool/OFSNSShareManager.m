//
//  OFSNSShareManager.m
//  OFSNSTool
//
//  Created by MikeZhangpy on 16/3/14.
//  Copyright © 2016年 MikeZhangpy. All rights reserved.
//

#import "OFSNSShareManager.h"

@implementation OFSNSShareManager



+ (void)shareMessage:(OSMessage *)message withShareType:(OFSNSShareType)shareType completionHandler:(void (^)(OSMessage *, NSError *))completionHandler {
    if (shareType == OFSNSShareTypeWeibo) {
        
        if ([OpenShare isWeiboInstalled]) {
            [OpenShare shareToWeibo:message Success:^(OSMessage *message) {
                if (completionHandler) {
                    NSLog(@"新浪微博分享成功！");
                    completionHandler(message, nil);
                }
            } Fail:^(OSMessage *message, NSError *error) {
                if (completionHandler) {
                    NSLog(@"新浪微博分享失败！--description:%@",error.localizedDescription);
                    completionHandler(message, error);
                }
            }];
        }else {
            
        }
    } else if (shareType == OFSNSShareTypeQQZone) {
        [OpenShare shareToQQZone:message Success:^(OSMessage *message) {
            if (completionHandler) {
                NSLog(@"QQ空间分享成功！");
                completionHandler(message, nil);
            }
        } Fail:^(OSMessage *message, NSError *error) {
            if (completionHandler) {
                 NSLog(@"QQ空间分享失败！--description:%@",error.localizedDescription);
                completionHandler(message, error);
            }
        }];
    } else if (shareType == OFSNSShareTypeQQ) {
        [OpenShare shareToQQFriends:message Success:^(OSMessage *message) {
            if (completionHandler) {
                NSLog(@"QQ分享成功！");
                completionHandler(message, nil);
            }
        } Fail:^(OSMessage *message, NSError *error) {
            if (completionHandler) {
                NSLog(@"QQ分享失败！--description:%@",error.localizedDescription);
                completionHandler(message, error);
            }
        }];
    } else if (shareType == OFSNSShareTypeWXMoment) {
        
        if ([OpenShare isWeixinInstalled]) {
            [OpenShare shareToWeixinTimeline:message Success:^(OSMessage *message) {
                if (completionHandler) {
                    NSLog(@"微信朋友圈分享成功！");
                    completionHandler(message, nil);
                }
            } Fail:^(OSMessage *message, NSError *error) {
                if (completionHandler) {
                    NSLog(@"微信朋友圈分享失败！--description:%@",error.localizedDescription);
                    completionHandler(message, error);
                }
            }];
        }
        
    } else if (shareType == OFSNSShareTypeWXSession) {
        
        if ([OpenShare isWeixinInstalled]) {
            
            [OpenShare shareToWeixinSession:message Success:^(OSMessage *message) {
                if (completionHandler) {
                    NSLog(@"微信好友分享成功！");
                    completionHandler(message, nil);
                }
            } Fail:^(OSMessage *message, NSError *error) {
                if (completionHandler) {
                    NSLog(@"微信号有分享失败！--description:%@",error.localizedDescription);
                    completionHandler(message, error);
                }
            }];
        }
    }
}

+(BOOL)checkShareButtonStatus {
    if (![OpenShare isWeiboInstalled] && ![OpenShare isWeixinInstalled]) {
        return NO;
    }
    return YES;
}

@end
