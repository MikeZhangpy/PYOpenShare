//
//  OFShareItem.m
//  MStore
//
//  Created by MikeZhangpy on 16/5/12.
//  Copyright © 2016年 RoseVision. All rights reserved.
//

#import "OFShareItem.h"

@implementation OFShareItem
-(instancetype)initWithTitle:(NSString *)title Icon:(NSString *)icon shareType:(OFSNSShareType)shareType{
    self = [super init];
    if (self) {
        self.title = title;
        self.icon = icon;
        self.shareType = shareType;
    }
    return self;
}

- (void)dealloc{
}
@end
