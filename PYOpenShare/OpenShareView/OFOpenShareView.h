//
//  OFOpenShareView.h
//  MStore
//
//  Created by MikeZhangpy on 16/5/12.
//  Copyright © 2016年 RoseVision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenShare.h"
#import "OpenShareHeader.h"
#import "OFShareItem.h"

typedef void (^shareCompletionHandler) (OSMessage *message, NSError *error);

@interface OFOpenShareView : UIView


/**
 *  不同平台分享不同文案
 *
 *  @param view              currentShareView
 *  @param array             ShareItemArray
 *  @param messages          ShareModelArray
 *  @param completionHandler callBack
 *
 *  @return OFOpenShareView
 */
+ (instancetype)showToView:(UIView *)view withItems:(NSArray *)array messages:(NSArray *)messages completionHandler:(shareCompletionHandler)completionHandler;

/**
 *  公共分享
 *
 *  @param view              currentShareView
 *  @param array             ShareItemArray
 *  @param message           ShareModel
 *  @param completionHandler callBack
 *
 *  @return OFOpenShareView
 */
+ (instancetype)showToView:(UIView *)view withItems:(NSArray *)array message:(OSMessage *)message completionHandler:(shareCompletionHandler)completionHandler;

+ (instancetype)showToView:(UIView *)view andImages:(NSArray *)imageArray andTitles:(NSArray *)titles message:(OSMessage *)message completionHandler:(shareCompletionHandler)completionHandler;
@end
