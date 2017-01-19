//
//  OFSNSShareManager.h
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
 *  分享管理类
 */
@interface OFSNSShareManager : NSObject

/**
 *  分享消息的内容到相应平台
 *
 *  @param message           分享消息
 *  @param shareType         分享类型
 *  @param completionHandler 成功失败代理
 */
+ (void)shareMessage:(OSMessage *)message withShareType:(OFSNSShareType)shareType completionHandler:(void (^)(OSMessage *message, NSError *error))completionHandler;

/**
 *  判断是否需要显示分享按钮
 *
 *  @return true 需要显示   false 不需要显示
 */
+ (BOOL)checkShareButtonStatus;
@end
