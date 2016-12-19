//
//  YTMessageTopCell.m
//  YuanDing_HuanXin
//
//  Created by 余婷 on 2016/12/15.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "YTMessageTopCell.h"

@interface YTMessageTopCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;





@end

@implementation YTMessageTopCell

#pragma mark - 数据
- (void)setCount:(int)count{

    _count = count;
    self.countLabel.text = [NSString stringWithFormat:@"%d",count];
}
- (void)setDataDict:(NSDictionary *)dataDict{

    _dataDict = dataDict;
    
    self.iconImageView.image = [UIImage imageNamed:dataDict[@"image"]];
    self.nameLabel.text = dataDict[@"name"];
    
}

@end
