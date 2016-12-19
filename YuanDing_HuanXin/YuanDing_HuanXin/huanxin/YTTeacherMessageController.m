//
//  YTTeacherMessageController.m
//  YuanDing_HuanXin
//
//  Created by 余婷 on 2016/12/15.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "YTTeacherMessageController.h"
#import "HuanXinManager.h"
#import "YTMessageTopCell.h"
#import "YTMessageListCell.h"
#import "YTGroupChatViewController.h"

@interface YTTeacherMessageController ()

//第一个分组的数据
@property(nonatomic, strong) NSMutableArray* topDataArray;

//相关群的数据
@property(nonatomic, strong) NSMutableArray* dataSource;

@end

@implementation YTTeacherMessageController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    [self refreshGrounpData];
}

#pragma mark - 界面相关  
- (void)creatUI{

    //1.tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"YTMessageTopCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YTMessageListCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    self.tableView.sectionFooterHeight = 0;
    
}

#pragma mark - 数据准备
- (void)refreshGrounpData{

    [[HuanXinManager shareManager] hx_getAllGrounp:^(NSArray * grounps) {
        
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:grounps];
        [self.tableView reloadData];
    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataSource{

    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray new];
    }
    
    return _dataSource;
}
- (NSMutableArray *)topDataArray{

    if (_topDataArray == nil) {
        
        _topDataArray = [[NSMutableArray alloc] initWithObjects:@{@"name":@"评论",@"image":@"pinglun"},@{@"name":@"提醒",@"image":@"pinglun"},@{@"name":@"打赏",@"image":@"pinglun"},@{@"name":@"假条",@"image":@"pinglun"}, nil];
    }
    
    return _topDataArray;
}

#pragma mark - tableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        
        return self.topDataArray.count;
    }
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //第一个分组
    if (indexPath.section == 0) {
        
        YTMessageTopCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        
        NSDictionary * dataDict = self.topDataArray[indexPath.row];
        cell.dataDict = dataDict;
        
        return cell;
    }
    //第二个分组
    YTMessageListCell * listCell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    
    EMGroup * group = self.dataSource[indexPath.row];
    listCell.group = group;
    
    return listCell;
    
    
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 0;
    }
    
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        
        YTGroup * group = self.dataSource[indexPath.row];
        
        YTGroupChatViewController * groupVC = [[YTGroupChatViewController alloc] initWithConversationChatter:group.groupId conversationType:EMConversationTypeGroupChat];
        groupVC.currentGroup = group;
        [HuanXinManager shareManager].currentClientId = group.clientId;
        
        [self.navigationController pushViewController:groupVC animated:YES];
    }
}

@end
