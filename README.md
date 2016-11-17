# ZSMenuView
一个类似于钉钉的动态弹窗，一键集成，后续会持续更新。/n

eg:
 [ZSMenuList createMenuView:@[@"select",@"select",@"select",@"select",@"select",@"select",@"select"] 
             title:@[@"你好啊",@"你好啊",@"你好啊",@"你好啊",@"你好啊",@"你好啊",@"你好啊"] 
             selIndex:^(NSInteger index) {
                   NSLog(@"%ld",(long)index);
    }];
  
效果图如下：
![image](https://github.com/18639460167/ZSMenuView/blob/master/ZSMenuView/1.gif)
