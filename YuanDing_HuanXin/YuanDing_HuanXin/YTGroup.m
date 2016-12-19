//
//  YTGroup.m
//  YuanDing_HuanXin
//
//  Created by 余婷 on 2016/12/16.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "YTGroup.h"

@implementation YTGroup

- (instancetype)initWithEMGroup:(EMGroup*)group{

    if (self = [super init]) {
        
        _groupId = group.groupId;
        _subject = group.subject;
        _occupantsCount = group.occupantsCount;
        _membersCount = group.membersCount;
        _setting = group.setting;
        _owner = group.owner;
        _members = group.members;
        _blackList = group.blackList;
        _occupants = group.occupants;
        _isPushNotificationEnabled = group.isPushNotificationEnabled;
        _isPublic = group.isPublic;
        _isBlocked = group.isBlocked;
        
        
    }
    return self;
}

@end
