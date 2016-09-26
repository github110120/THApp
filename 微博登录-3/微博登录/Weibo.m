//
//  Weibo.m
//  微博登录
//
//  Created by tarena on 16/8/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Weibo.h"

@implementation Weibo
-(instancetype)initWithDic:(NSDictionary *)weiboDic{
    self = [super init];
    
    if (self) {
        self.text = weiboDic[@"text"];
        self.created_at = weiboDic[@"created_at"];
        self.source = weiboDic[@"source"];
        
        
        NSDictionary *userDic = weiboDic[@"user"];
        
        User *user = [User new];
        user.name = userDic[@"name"];
        user.avatar_hd = userDic[@"avatar_hd"];
        self.user = user;
    }
    
    return self;
}
@end
