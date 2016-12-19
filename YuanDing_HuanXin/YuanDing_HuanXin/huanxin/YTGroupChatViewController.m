//
//  YTGroupChatViewController.m
//  YuanDing_HuanXin
//
//  Created by 余婷 on 2016/12/15.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "YTGroupChatViewController.h"
#import "EaseEmotionManager.h"
#import "EaseEmoji.h"
#import "YTGroupMemberInfoViewController.h"

@interface YTGroupChatViewController ()<EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource>
@property (nonatomic) NSMutableDictionary *emotionDic;

@end

@implementation YTGroupChatViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self creatUI];
}

#pragma mark - 界面相关
- (void)creatUI{

    //1.设置聊天气泡
    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[UIImage imageNamed:@"right"]];
    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[UIImage imageNamed:@"left"]];
    //2.设置消息文字颜色
    [[EaseMessageCell appearance] setMessageTextColor:[UIColor whiteColor]];
    
    //3.设置头像和昵称
    self.dataSource = self;
    //设置头像大小
    [[EaseBaseMessageCell appearance] setAvatarSize:30.f];
    
    //4.背景
    self.tableView.backgroundColor = [UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1];
    
    //5.设置导航条
    //a.返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"UIBarButtonItemArrowLeft"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"UM_allfamily"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(groupInfoAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

#pragma mark - 按钮点击事件
- (void)groupInfoAction{

    YTGroupMemberInfoViewController * groupMemBerVC = [YTGroupMemberInfoViewController new];
    groupMemBerVC.title = @"成员";
    groupMemBerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:groupMemBerVC animated:YES];
}
- (void)backAction{

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - EaseCell DataSource
- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController modelForMessage:(EMMessage *)message{

    id<IMessageModel> model = nil;
    
    model = [[EaseMessageModel alloc] initWithMessage:message];
    //设置默认头像
    model.avatarImage = [UIImage imageNamed:@"chatIcon"];
    //设置头像URL
    model.avatarURLPath = @"";
    //设置昵称
    model.nickname = message.from;
    
    return model;
}

//添加表情
- (NSArray*)emotionFormessageViewController:(EaseMessageViewController *)viewController
{
    NSMutableArray *emotions = [NSMutableArray array];



    int i = 0;
    int count = [EaseEmoji allEmoji].count;
    for (NSString * name in [EaseEmoji allEmoji]) {
        
        if (i > count - 2) {
            
            break;
        }
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionDefault];
        [emotions addObject:emotion];
        
        i += 1;
    }
    
    EaseEmotion *temp = [emotions objectAtIndex:0];
    EaseEmotionManager *managerDefault = [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:6 emotions:emotions tagImage:[UIImage imageNamed:temp.emotionId]];
    
    NSMutableArray *emotionGifs = [NSMutableArray array];
    _emotionDic = [NSMutableDictionary dictionary];
    NSArray *names = @[@"icon_002",@"icon_007",@"icon_010",@"icon_012",@"icon_013",@"icon_018",@"icon_019",@"icon_020",@"icon_021",@"icon_022",@"icon_024",@"icon_027",@"icon_029",@"icon_030",@"icon_035",@"icon_040"];
    int index = 0;
    for (NSString *name in names) {
        index++;
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:[NSString stringWithFormat:@"",index] emotionId:[NSString stringWithFormat:@"em%d",(1000 + index)] emotionThumbnail:[NSString stringWithFormat:@"%@_cover",name] emotionOriginal:[NSString stringWithFormat:@"%@",name] emotionOriginalURL:@"" emotionType:EMEmotionGif];
        [emotionGifs addObject:emotion];
        [_emotionDic setObject:emotion forKey:[NSString stringWithFormat:@"em%d",(1000 + index)]];
    }
    EaseEmotionManager *managerGif= [[EaseEmotionManager alloc] initWithType:EMEmotionGif emotionRow:2 emotionCol:4 emotions:emotionGifs tagImage:[UIImage imageNamed:@"icon_002_cover"]];
    
    return @[managerDefault,managerGif];
}

- (BOOL)isEmotionMessageFormessageViewController:(EaseMessageViewController *)viewController
                                    messageModel:(id<IMessageModel>)messageModel
{
    BOOL flag = NO;
    if ([messageModel.message.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
        return YES;
    }
    return flag;
}

- (EaseEmotion*)emotionURLFormessageViewController:(EaseMessageViewController *)viewController
                                      messageModel:(id<IMessageModel>)messageModel
{
    NSString *emotionId = [messageModel.message.ext objectForKey:MESSAGE_ATTR_EXPRESSION_ID];
    EaseEmotion *emotion = [_emotionDic objectForKey:emotionId];
    if (emotion == nil) {
        emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:emotionId emotionThumbnail:@"" emotionOriginal:@"" emotionOriginalURL:@"" emotionType:EMEmotionGif];
    }
    return emotion;
}

- (NSDictionary*)emotionExtFormessageViewController:(EaseMessageViewController *)viewController
                                        easeEmotion:(EaseEmotion*)easeEmotion
{
    return @{MESSAGE_ATTR_EXPRESSION_ID:easeEmotion.emotionId,MESSAGE_ATTR_IS_BIG_EXPRESSION:@(YES)};
}

- (void)messageViewControllerMarkAllMessagesAsRead:(EaseMessageViewController *)viewController
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
}



@end
