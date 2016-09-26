//
//  WeibosTableViewController.m
//  微博登录
//
//  Created by tarena on 16/8/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "WeibosTableViewController.h"
#import "Weibo.h"
#import "User.h"
@interface WeibosTableViewController ()
@property (nonatomic, strong)NSMutableArray *weibos;
@end

@implementation WeibosTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.weibos = [NSMutableArray array];
    
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
   NSString *path = @"https://api.weibo.com/2/statuses/home_timeline.json";
    //添加参数
    path = [path stringByAppendingFormat:@"?access_token=%@",token];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@",dic);
        NSArray *weibosArr = dic[@"statuses"];
        for (NSDictionary *weiboDic in weibosArr) {
            //把装着微博信息的字典转成模型层的Weibo对象
            Weibo *weibo = [[Weibo alloc]initWithDic:weiboDic];
            [self.weibos addObject:weibo];
        }
        
        //刷新页面
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        
    }];
    
    [task resume];
    
    
    
    //注册Cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return self.weibos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Weibo *weibo = self.weibos[indexPath.row];
    cell.textLabel.text = weibo.text;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
