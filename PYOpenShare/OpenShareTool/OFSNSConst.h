//
//  OFSNSConst.h
//  OFSNSTool
//
//  Created by MikeZhangpy on 16/3/14.
//  Copyright © 2016年 MikeZhangpy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 社会平台类型
 */
typedef enum : NSUInteger {
    OFSNSPlatFromQQ = 0,
    OFSNSPlatFromWeibo,
    OFSNSPlatFromWeiXin,
} OFSNSPlatType;

/**
 定义分享类型
 */
typedef enum : NSUInteger {
    OFSNSShareTypeWXMoment = 0,  // 分享到微信圈
    OFSNSShareTypeWXSession,     // 分享到微信朋友
    OFSNSShareTypeWeibo,               // 分享到新浪微博
    OFSNSShareTypeCopyLink,            //分享链接
    OFSNSShareTypeQQ,                  // 分享到QQ好友
    OFSNSShareTypeQQZone,              // 分享到QQ空间

} OFSNSShareType;

// 定义相关常量定义Key

static NSString *const kSNSPlatWeixinKey           = @"wxcb73418fefe8c03f";
static NSString *const kSNSPlatWeixinSecretKey     = @"kSNSPlatformWeixinSecretKey";

static NSString *const kSNSPlatQQKey               = @"801189857";
static NSString *const kSNSPlatQQSecretKey         = @"5f511fee374e2b57925bcdbd202e940d";

static NSString *const kSNSPlatWeiboKey            = @"3251711109";
static NSString *const kSNSPlatWeiboSecretKey      = @"24a0f1401998871409ab44cb908628c4";
static NSString *const kSNSPlatWeiboRedirectURIKey = @"http://sina/login.html";


