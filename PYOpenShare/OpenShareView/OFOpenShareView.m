//
//  OFOpenShareView.m
//  MStore
//
//  Created by MikeZhangpy on 16/5/12.
//  Copyright © 2016年 RoseVision. All rights reserved.
//

#import "OFOpenShareView.h"
#import "OFShareCenterView.h"
#import "OFSNSShareManager.h"
#import "UIImage+ShareImageEffects.h"

static CGFloat centerViewHeight;

@interface OFOpenShareView()<
OFCenterViewDataSource,OFCenterViewDelegate
>

@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) OFShareCenterView *centerView;
@property (nonatomic, strong) UIButton *bottomBtn;

@property (nonatomic,strong) NSArray * items;

@property (strong, nonatomic) OSMessage *message;

/**
 *  用于不同平台传输不同message
 */
@property (nonatomic, strong) NSArray *messages;

@property (nonatomic, copy) void (^shareCompletionHandler) (OSMessage *message, NSError *error);
@end

@implementation OFOpenShareView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0;
        self.background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.background];
        
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.frame = self.bounds;
        backgroundView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5f];
        [self addSubview:backgroundView];
        
        self.centerView = [[OFShareCenterView alloc]initWithFrame:CGRectMake(0, self.frame.size.height * 0.37, self.frame.size.width, self.frame.size.height * 0.4)];
        [self addSubview:self.centerView];
        self.centerView.delegate = self;
        self.centerView.dataSource = self;
        self.centerView.clipsToBounds = NO;
        
        self.bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bottomBtn.frame = CGRectMake(30, self.bounds.size.height - 60, self.bounds.size.width - 60, 40);
        [self.bottomBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        self.bottomBtn.layer.borderWidth = 1.0f;
        self.bottomBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        self.bottomBtn.layer.cornerRadius = 4;
        self.bottomBtn.layer.masksToBounds = YES;
        [self.bottomBtn addTarget:self action:@selector(cancelEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.bottomBtn];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bottomBtn.frame = CGRectMake(30, self.bounds.size.height - 60, self.bounds.size.width - 60, 40);
    self.centerView.frame = CGRectMake(0, CGRectGetMinY(self.bottomBtn.frame) -20 - centerViewHeight, self.bounds.size.width, centerViewHeight);
}

- (void)showItems{
    [self.centerView reloadData];
}

- (void)hideItems{
    [self.centerView dismiss];
}

+ (instancetype)showToView:(UIView *)view withItems:(NSArray *)array messages:(NSArray *)messages completionHandler:(shareCompletionHandler)completionHandler {
    [self viewNotEmpty:view];
    OFOpenShareView * popView = [[OFOpenShareView alloc]initWithFrame:view.bounds];
    popView.background.image = [self imageWithView:view];
    [view addSubview:popView];
    
    popView.shareCompletionHandler = completionHandler;
    popView.messages = messages;
    [UIView animateWithDuration:0.2 animations:^{
        popView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    popView.items = array;
    
    if (popView.items.count > 3) {
        centerViewHeight = [UIScreen mainScreen].bounds.size.width/3*2;
    }else {
        centerViewHeight = [UIScreen mainScreen].bounds.size.width/3;
    }
    [popView showItems];
    return popView;
}

+ (instancetype)showToView:(UIView *)view withItems:(NSArray *)array message:(OSMessage *)message completionHandler:(void (^)(OSMessage *, NSError *))completionHandler{
    [self viewNotEmpty:view];
    OFOpenShareView * popView = [[OFOpenShareView alloc]initWithFrame:view.bounds];
    popView.background.image = [self imageWithView:view];
    [view addSubview:popView];
    
    popView.shareCompletionHandler = completionHandler;
    popView.message = message;
    [UIView animateWithDuration:0.2 animations:^{
        popView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    popView.items = array;
    
    if (popView.items.count > 3) {
        centerViewHeight = [UIScreen mainScreen].bounds.size.width/3*2;
    }else {
        centerViewHeight = [UIScreen mainScreen].bounds.size.width/3;
    }
    [popView showItems];
    return popView;
}

+(instancetype)showToView:(UIView *)view andImages:(NSArray *)imageArray andTitles:(NSArray *)titles message:(OSMessage *)message completionHandler:(void (^)(OSMessage *, NSError *))completionHandler {
    NSUInteger count = imageArray.count;
    NSMutableArray * items = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        OFShareItem * item = [[OFShareItem alloc]initWithTitle:titles[i] Icon:imageArray[i] shareType:0];
        item.shareType = i;
        [items addObject:item];
    }
    return [self showToView:view withItems:items message:message completionHandler:completionHandler];
}

+ (void)viewNotEmpty:(UIView *)view{
    if (view == nil) {
        view = (UIView *)[[UIApplication sharedApplication] delegate];
    }
    
}

+ (UIImage *)imageWithView:(UIView *)view{
    UIImage * image = [self screenshot];
    image = [image applyBlurWithRadius:5.f tintColor:[UIColor colorWithWhite:1.0 alpha:0.2] saturationDeltaFactor:1.8 maskImage:nil];
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)screenshot
{
    CGSize imageSize = CGSizeZero;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = [UIScreen mainScreen].bounds.size;
    } else {
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        } else if (orientation == UIInterfaceOrientationLandscapeRight) {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        } else {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (void)hideFromView:(UIView *)view{
    [self viewNotEmpty:view];
    [view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView * subV = (UIView *)obj;
        [subV isKindOfClass:[self class]];
        [OFOpenShareView hideWithView:subV];
    }];
}

- (void)hide{
    [OFOpenShareView hideWithView:self];
}

+ (void)hideWithView:(UIView *)view{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.alpha = 1;
        [UIView animateWithDuration:0.5 animations:^{
            view.alpha = 0;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    });
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.bottomBtn.alpha = 1;
    [UIView animateWithDuration:.4 animations:^{
        self.bottomBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [self.bottomBtn removeFromSuperview];
    }];
    
    [self hideItems];
    [self hide];
}

- (void)cancelEvent:(UIButton *)btn {
    
    self.bottomBtn.alpha = 1;
    [UIView animateWithDuration:.4 animations:^{
        self.bottomBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [self.bottomBtn removeFromSuperview];
    }];
    [self hideItems];
    [self hide];
}

#pragma mark centerview delegate and datasource
- (NSInteger)numberOfItemsWithCenterView:(OFShareCenterView *)centerView
{
    return self.items.count;
}

-(OFShareItem *)itemWithCenterView:(OFShareCenterView *)centerView item:(NSInteger)item
{
    return self.items[item];
}

-(void)didSelectItemWithCenterView:(OFShareCenterView *)centerView andItem:(OFShareItem *)item
{
//    if (self.selectBlock) {
//        self.selectBlock(item);
//    }
    if (item.shareType == OFSNSShareTypeCopyLink) {
        
        for (OSMessage *message in self.messages) {
            if (message.inShareType == OFSNSShareTypeCopyLink) {
                
                if (self.shareCompletionHandler) {
                    self.shareCompletionHandler(message,nil);
                }
            }
        }
        [self hide];
        return;
    }
    
    if (self.messages.count > 0) {
        
        for (OSMessage *message in self.messages) {
            if (message.inShareType == item.shareType) {
                 [OFSNSShareManager shareMessage:message withShareType:item.shareType completionHandler:self.shareCompletionHandler];
            }
        }
    }else {
        [OFSNSShareManager shareMessage:self.message withShareType:item.shareType completionHandler:self.shareCompletionHandler];
    }
    
    [self hide];
}

- (void)dealloc{
}


@end
