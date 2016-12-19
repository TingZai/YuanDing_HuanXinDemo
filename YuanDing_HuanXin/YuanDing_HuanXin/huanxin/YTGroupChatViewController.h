//
//  YTGroupChatViewController.h
//  YuanDing_HuanXin
//
//  Created by 余婷 on 2016/12/15.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseMessageViewController.h"
#import "HuanXinManager.h"

@interface YTGroupChatViewController : EaseMessageViewController

/**
 当前群组
 */
@property(nonatomic,strong) YTGroup * currentGroup;

@end
