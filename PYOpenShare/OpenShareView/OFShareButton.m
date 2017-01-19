//
//  OFShareButton.m
//  MStore
//
//  Created by MikeZhangpy on 16/5/12.
//  Copyright © 2016年 RoseVision. All rights reserved.
//

#import "OFShareButton.h"

@implementation OFShareButton
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect rect = CGRectMake(0, (contentRect.size.height - ICONHEIGHT - TITLEHEIGHT) / 2, contentRect.size.width, ICONHEIGHT);
    return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectMake(0, (contentRect.size.height - ICONHEIGHT - TITLEHEIGHT) / 2 + ICONHEIGHT, contentRect.size.width, TITLEHEIGHT);
    return rect;
}

-(void)setHighlighted:(BOOL)highlighted
{
    
}

- (void)dealloc{
}


@end
