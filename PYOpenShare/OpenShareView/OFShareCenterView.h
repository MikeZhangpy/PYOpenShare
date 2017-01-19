//
//  OFShareCenterView.h
//  MStore
//
//  Created by MikeZhangpy on 16/5/12.
//  Copyright © 2016年 RoseVision. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OFShareItem,OFShareCenterView;
@protocol OFCenterViewDataSource <NSObject>
@required
- (NSInteger)numberOfItemsWithCenterView:(OFShareCenterView *)centerView;
- (OFShareItem *)itemWithCenterView:(OFShareCenterView *)centerView item:(NSInteger)item;

@end

@protocol OFCenterViewDelegate <NSObject,UIScrollViewDelegate>

@optional
- (void)didSelectItemWithCenterView:(OFShareCenterView *)centerView andItem:(OFShareItem *)item;
@end

@interface OFShareCenterView : UIScrollView

@property (nonatomic,weak) id<OFCenterViewDataSource> dataSource;
@property (nonatomic,weak) id<OFCenterViewDelegate> delegate;

- (void)reloadData;

- (void)scrollBack;

- (void)dismiss;
@end
