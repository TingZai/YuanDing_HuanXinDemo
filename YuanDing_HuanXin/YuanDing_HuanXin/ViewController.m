//
//  ViewController.m
//  YuanDing_HuanXin
//
//  Created by 余婷 on 2016/12/15.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "ViewController.h"
#import "HuanXinManager.h"
#import "YTTeacherMessageController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //登录幼信通
    
    [[HuanXinManager shareManager] hx_Login:^{
        
        YTTeacherMessageController * teachVC = [[YTTeacherMessageController alloc] initWithStyle:UITableViewStyleGrouped];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:teachVC];
        
        [self presentViewController:nav animated:YES completion:nil];
    }];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
