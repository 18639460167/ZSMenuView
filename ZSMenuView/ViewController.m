//
//  ViewController.m
//  ZSMenuView
//
//  Created by tenpastnine-ios-dev on 16/11/10.
//  Copyright © 2016年 Black. All rights reserved.
//

#import "ViewController.h"
#import "ZSMenuList.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    image.image = [UIImage imageNamed:@"h6"];
    [self.view addSubview:image];
    
    UIButton *button = [UIButton buttonWithType:0];
    button.backgroundColor = [UIColor orangeColor];
    button.frame = CGRectMake(50, 50, 60, 60);
    [button addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)btnAction
{
    [ZSMenuList createMenuView:@[@"select",@"select",@"select",@"select",@"select",@"select",@"select"] title:@[@"你好啊",@"你好啊",@"你好啊",@"你好啊",@"你好啊",@"你好啊",@"你好啊"] selIndex:^(NSInteger index) {
        NSLog(@"%ld",(long)index);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
