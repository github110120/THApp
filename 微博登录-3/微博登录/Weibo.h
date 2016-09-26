//
//  Weibo.h
//  微博登录
//
//  Created by tarena on 16/8/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Weibo : NSObject
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *created_at;
@property (nonatomic, copy)NSString *source;
@property (nonatomic, strong)User *user;

-(instancetype)initWithDic:(NSDictionary *)weiboDic;
@end
