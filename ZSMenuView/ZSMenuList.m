//
//  ZSMenuList.m
//  ZSAlert
//
//  Created by tenpastnine-ios-dev on 16/11/10.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "ZSMenuList.h"
#define MENU_WIDTH 60
#define MENU_HEIGHT 80
#define IMAGE_DISPATCH 5 // image距离边距的距离
#define FONT_SIZE 14.0 // 默认字体大小
#define totalloc 4 // 默认是3列
#define MENU_SPACING 30 // menu上下间距
#define TOP_SPACING 50 // 其实y值

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation zsView

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGE_DISPATCH, IMAGE_DISPATCH, MENU_WIDTH-(IMAGE_DISPATCH*2), MENU_WIDTH-(IMAGE_DISPATCH*2))];
        image.image = [UIImage imageNamed:imageName];
        [self addSubview:image];
        
        UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame), MENU_WIDTH, MENU_HEIGHT-CGRectGetMaxY(image.frame))];
        titleLbl.text = title;
        titleLbl.textColor = [UIColor lightGrayColor];
        titleLbl.font = [UIFont systemFontOfSize:FONT_SIZE];
        titleLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLbl];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        button.frame = CGRectMake(0, 0, MENU_WIDTH, MENU_HEIGHT);
        [button addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

/**
 *  menu点击事件
 */
- (void)btnAction
{
    self.menuAction(0);
}

@end
@interface ZSMenuList()
{
    NSArray *imageArr;
    NSArray *titleArr;
}
@property (nonatomic, copy)selectAction handler;
@end
@implementation ZSMenuList

+ (void)createMenuView:(NSArray *)imageNameArray title:(NSArray *)titleArray selIndex:(selectAction)backAction
{
    ZSMenuList *list = [[ZSMenuList alloc]initWithFrame:[UIScreen mainScreen].bounds MenuView:imageNameArray title:titleArray selIndex:backAction];
    [list show];
}
- (instancetype)initWithFrame:(CGRect)frame MenuView:(NSArray *)imageNameArray title:(NSArray *)titleArray selIndex:(selectAction)backAction
{
    if (self = [super initWithFrame:frame])
    {
        imageArr = imageNameArray;
        titleArr = titleArray;
        self.handler = backAction;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)createMenu
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [visualEffectView setFrame:self.bounds];
    [self addSubview:visualEffectView];
    
    CGFloat margin=(SCREEN_WIDTH-totalloc*MENU_WIDTH)/(totalloc+1);
    NSInteger last  =imageArr.count/totalloc;
    float topY  = TOP_SPACING+(MENU_SPACING+MENU_HEIGHT)*last;
    for (int i=0; i<imageArr.count; i++)
    {
        NSInteger row = i/totalloc; // 行号
        NSInteger loc = i%totalloc; // 列号
        CGFloat appviewx=margin+(margin+MENU_WIDTH)*loc;
        CGFloat appviewy=TOP_SPACING+(MENU_SPACING+MENU_HEIGHT)*row;
        zsView *view = [[zsView alloc]initWithFrame:CGRectMake(appviewx, -topY, MENU_WIDTH, MENU_HEIGHT) imageName:imageArr[i] title:titleArr[i]];
        __weak typeof(self) WSelf = self;
        view.tag = i+1;
        view.menuAction = ^(NSInteger index)
        {
            WSelf.handler(i);
            [self hide];
        };
        [self addSubview:view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            //UIView animate动画:仿钉钉弹出添加按钮,从顶部弹到指定位置
            [UIView animateWithDuration:1.f delay:(0.2-0.02*i) usingSpringWithDamping:1.0f initialSpringVelocity:15.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                view.frame = CGRectMake(appviewx, appviewy, MENU_WIDTH,MENU_HEIGHT);
            } completion:^(BOOL finished) {
            }];
        });
    }
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    [self createMenu];
}
- (void)hide
{
    NSInteger last  =imageArr.count/totalloc;
    float topY  = TOP_SPACING+(MENU_SPACING+MENU_HEIGHT)*last;
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:[zsView class]])
        {
            zsView *myView=(zsView *)view;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                //UIView animate动画:仿钉钉弹出添加按钮,从顶部弹到指定位置
                [UIView animateWithDuration:1.f delay:0.02*(myView.tag-1) usingSpringWithDamping:0.6f initialSpringVelocity:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    myView.frame = CGRectMake(myView.frame.origin.x, -topY, MENU_WIDTH,MENU_HEIGHT);
                    self.alpha = 0;
                } completion:^(BOOL finished)
                {
                    [self removeFromSuperview];
                }];
            });
        }
    }
}

@end
