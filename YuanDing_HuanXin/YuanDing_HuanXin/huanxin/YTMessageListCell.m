//
//  YTMessageListCell.m
//  YuanDing_HuanXin
//
//  Created by 余婷 on 2016/12/15.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "YTMessageListCell.h"

@interface YTMessageListCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;



@end

@implementation YTMessageListCell

#pragma mark - 数据
- (void)setGroup:(YTGroup *)group{
    _group = group;
    
    self.titleLabel.text = group.subject;
    
}

@end
