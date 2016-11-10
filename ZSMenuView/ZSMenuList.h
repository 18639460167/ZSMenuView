//
//  ZSMenuList.h
//  ZSAlert
//
//  Created by tenpastnine-ios-dev on 16/11/10.
//  Copyright © 2016年 Black. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^selectAction)(NSInteger index);

@interface zsView : UIView

@property (nonatomic, copy) selectAction menuAction; // menu点击回调block

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title;

@end

@interface ZSMenuList : UIView

/**
 *  imageArray必须和titlearray的个数相等
 *
 *  @param imageNameArray 图片数组
 *  @param titleArray     文本数组
 *  @param backAction     menu回调block
 *
 */
+ (void)createMenuView:(NSArray *)imageNameArray title:(NSArray *)titleArray selIndex:(selectAction)backAction;

@end
