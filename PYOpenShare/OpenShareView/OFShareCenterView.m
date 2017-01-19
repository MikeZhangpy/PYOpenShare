//
//  OFShareCenterView.m
//  MStore
//
//  Created by MikeZhangpy on 16/5/12.
//  Copyright © 2016年 RoseVision. All rights reserved.
//

#import "OFShareCenterView.h"
#import "OFShareItem.h"
#import "OFShareButton.h"

@interface OFShareCenterView()
@property (nonatomic,strong) NSMutableArray * visableBtnArray;
@property (nonatomic,strong) NSMutableArray * homeBtns;
@property (nonatomic,assign) BOOL btnCanceled;
@end

@implementation OFShareCenterView
@dynamic delegate;

-(NSMutableArray *)homeBtns
{
    if (!_homeBtns) {
        _homeBtns = [NSMutableArray array];
    }
    return _homeBtns;
}

-(NSMutableArray *)visableBtnArray
{
    if (!_visableBtnArray) {
        _visableBtnArray = [NSMutableArray array];
    }
    return _visableBtnArray;
}


- (void)reloadData{
    [self.homeBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.homeBtns removeAllObjects];
    NSUInteger count = [self.dataSource numberOfItemsWithCenterView:self];
    NSMutableArray * items = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        [items addObject:[self.dataSource itemWithCenterView:self item:i]];
        
    }
    [self layoutBtnsWith:items isMore:NO];
    [self btnPositonAnimation:NO];
}

- (void)layoutBtnsWith:(NSArray *)items isMore:(BOOL)isMore{
    OFShareItem * item;
    for (int i = 0; i < items.count; i ++) {
        item = items[i];
        OFShareButton * btn = [OFShareButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:item.icon] forState:UIControlStateNormal];
        [btn.imageView setContentMode:UIViewContentModeCenter];
        [btn setTitle:item.title forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        CGFloat x = (i % 3) * self.frame.size.width / 3.0;
        CGFloat y = (i / 3) * self.frame.size.height / 2.0;

        [self.homeBtns addObject:btn];
        CGFloat width = self.frame.size.width / 3.0;
        CGFloat height = self.frame.size.height / 2;
        [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(didCancelBtn:) forControlEvents:UIControlEventTouchDragInside];
        [self addSubview:btn];
        btn.frame = CGRectMake(x, y, width, height);
    }
}

- (void)didTouchBtn:(OFShareButton *)btn{
    [UIView animateWithDuration:.15 animations:^{
        btn.transform = CGAffineTransformMakeScale(1.2,1.2);
    }];
}

- (void)didCancelBtn:(OFShareButton *)btn{
    self.btnCanceled = YES;
    [UIView animateWithDuration:.15 animations:^{
        btn.transform = CGAffineTransformMakeScale(1.0,1.0);
    }];
}

- (void)scrollBack{
    [self.visableBtnArray removeAllObjects];
    [self.homeBtns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self.visableBtnArray addObject:obj];
    }];
    [self setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)didClickBtn:(OFShareButton *)btn{
    if (self.btnCanceled) {
        self.btnCanceled = NO;
        return;
    }
    
    OFShareItem * item;
    NSInteger index;
    if([self.homeBtns containsObject:btn]){
        index = [self.homeBtns indexOfObject:btn];
        item = [self.dataSource itemWithCenterView:self item:index];
    }
    [UIView animateWithDuration:.2 animations:^{
        btn.transform = CGAffineTransformMakeScale(1.0,1.0);
    }];

    [UIView animateWithDuration:.2 animations:^{
        btn.transform = CGAffineTransformMakeScale(1.7,1.7);
    }];
    
    btn.alpha = 1;
    [UIView animateWithDuration:.2 animations:^{
        btn.alpha = 0;
    } completion:^(BOOL finished) {
//        [btn removeFromSuperview];
    }];
    [self.visableBtnArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        OFShareButton * b = obj;
        if (b != btn) {
            btn.alpha = 1;
            [UIView animateWithDuration:.2 animations:^{
                btn.transform = CGAffineTransformMakeScale(1.2,1.2);
                btn.alpha = 0;
            } completion:^(BOOL finished) {
//                [btn removeFromSuperview];
            }];
        }
    }];
    if (!self.delegate || ![self.delegate respondsToSelector:@selector(didSelectItemWithCenterView:andItem:)]) {
        return;
    }
    [self.delegate didSelectItemWithCenterView:self andItem:item];
}


- (void)dismiss{
    [self btnPositonAnimation:YES];
}

- (void)removeAnimation{
    [self.visableBtnArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        OFShareButton * btn = obj;
        CGFloat x = btn.frame.origin.x;
        CGFloat y = btn.frame.origin.y;
        CGFloat width = btn.frame.size.width;
        CGFloat height = btn.frame.size.height;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((self.visableBtnArray.count - idx) * 0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:5 options:0 animations:^{
                btn.alpha = 0;
                btn.frame = CGRectMake(x, [UIScreen mainScreen].bounds.size.height - self.frame.origin.y + y, width, height);
            } completion:^(BOOL finished) {
                if ([btn isEqual:[self.visableBtnArray firstObject]]) {
                    self.superview.superview.userInteractionEnabled = YES;
                }
            }];
        });
        
    }];
    
}

- (void)moveInAnimation{
    
    [self.visableBtnArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        OFShareButton * btn = obj;
        CGFloat x = btn.frame.origin.x;
        CGFloat y = btn.frame.origin.y;
        CGFloat width = btn.frame.size.width;
        CGFloat height = btn.frame.size.height;
        btn.frame = CGRectMake(x, [UIScreen mainScreen].bounds.size.height + y - self.frame.origin.y, width, height);
        btn.alpha = 0.0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(idx * 0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:25 options:UIViewAnimationOptionCurveEaseIn animations:^{
                btn.alpha = 1;
                btn.frame = CGRectMake(x, y, width, height);
            } completion:^(BOOL finished) {
                if ([btn isEqual:[self.visableBtnArray lastObject]]) {
                    self.superview.superview.userInteractionEnabled = YES;
                }
            }];
        });
        
    }];
}

- (void)btnPositonAnimation:(BOOL)isDismis{
    if (self.visableBtnArray.count <= 0) {
        [self.homeBtns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self.visableBtnArray addObject:obj];
        }];
    }
    self.superview.superview.userInteractionEnabled = NO;
    if (isDismis) {
        [self removeAnimation];
    }else{
        [self moveInAnimation];
    }
    
}

- (void)dealloc{
    
}


@end
