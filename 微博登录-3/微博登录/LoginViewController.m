//
//  LoginViewController.m
//  微博登录
//
//  Created by tarena on 16/8/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UIWebViewDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    webView.delegate = self;
    
    
    NSString *path = @"https://api.weibo.com/oauth2/authorize?client_id=586885323&redirect_uri=http://www.baidu.com";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    [webView loadRequest:request];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *path = [request.URL description];
    NSLog(@"%@",path);
    if ([path containsString:@"code"]) {
        NSString *code = [[path componentsSeparatedByString:@"="] lastObject];
        NSLog(@"得到code ：%@",code);
        //拿code换token
        NSString *path = @"https://api.weibo.com/oauth2/access_token";
        NSString *params = [NSString stringWithFormat:@"code=%@&client_id=586885323&client_secret=49b07898f60581be441804f5aada12bb&grant_type=authorization_code&redirect_uri=http://www.baidu.com",code];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
        
        
        
        //设置POST请求方式
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        
        //创建session
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
          
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSString *token = dic[@"access_token"];
            NSString *uid = dic[@"uid"];
         //把登录信息保存起来
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:token forKey:@"token"];
            [ud setObject:uid forKey:@"uid"];
            [ud synchronize];
            
           
            
            //返回页面
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
        }];
        [task resume];
        
        
        
        
        
        
        
     
        
        return NO;
        
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
