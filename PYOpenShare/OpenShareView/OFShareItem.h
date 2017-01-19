//
//  OFShareItem.h
//  MStore
//
//  Created by MikeZhangpy on 16/5/12.
//  Copyright © 2016年 RoseVision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OFSNSConst.h"


@interface OFShareItem : NSObject
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * icon;
@property (nonatomic,assign) OFSNSShareType shareType;

-(instancetype)initWithTitle:(NSString *)title Icon:(NSString *)icon shareType:(OFSNSShareType)shareType;

@end
