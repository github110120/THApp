//
//  ViewController.m
//  微博登录
//
//  Created by tarena on 16/8/15.
//  Copyright © 2016年 tarena. All rights reserved.
//
#import "WeibosTableViewController.h"
#import "ViewController.h"
#import "LoginViewController.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)clicked:(id)sender {
    WeibosTableViewController *vc = [WeibosTableViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)loginAction:(id)sender {
    
    
    LoginViewController *vc = [LoginViewController new];
    [self presentViewController:vc animated:YES completion:nil];
    
    
}
- (IBAction)sendAction:(id)sender {
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    
    if (token) {
        //要发送的微博文本内容
        NSString *info = @"今天下雨了";
        
        
        NSString *path = @"https://api.weibo.com/2/statuses/update.json";
        NSString *params = [NSString stringWithFormat:@"access_token=%@&status=%@",token,info];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
        //设置POST请求及参数
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"发送成功：%@",dic);
            NSLog(@"%@",[NSThread currentThread]);
           
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"微博发送完成" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [ac addAction:action1];
                [ac addAction:action2];
                
                [self presentViewController:ac animated:YES completion:nil];
                
                
            });
            
        }];
        
        
        
        [task resume];
        
        
    }
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
    
    
   
    
    
    
}

@end
