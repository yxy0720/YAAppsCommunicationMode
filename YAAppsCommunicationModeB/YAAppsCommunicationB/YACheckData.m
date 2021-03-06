//
//  YACheckData.m
//  YAAppsCommunicationB
//
//  Created by lanjiying on 2018/4/18.
//  Copyright © 2018年 lanjiying_Angelia. All rights reserved.
//

#import "YACheckData.h"
#import <UIKit/UIKit.h>
#import "YAKeyChain.h"

@implementation YACheckData
+ (void)checkKeyChainData
{
    NSDictionary *userinfo = [YAKeyChain keyChainReadData:@"userinfo"];
    if (userinfo) {
        NSArray *array = @[[NSString stringWithFormat:@"%@:%@",userinfo.allKeys[0],[userinfo objectForKey:userinfo.allKeys[0]]],[NSString stringWithFormat:@"%@:%@",userinfo.allKeys[1],[userinfo objectForKey:userinfo.allKeys[1]]],[userinfo objectForKey:userinfo.allKeys[2]]];
        [YACheckData showKeyChainData:array];
    }else{
        [YACheckData showMessageAlert:@"error" message:@"keyChain no data"];
    }
}
+ (void)checkPasteboard
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (pasteboard.URL) {
        [YACheckData showMessageAlert:@"read successfully" message:pasteboard.URL];
    }else{
        [YACheckData showMessageAlert:@"read failed" message:@"so sorry, it's failur to read url from pasteboard, please sure there is a url on pasteboard"];
    }
}
+ (void)cheakDocumentsData:(NSDictionary *)application
{
    if (application) {
        NSString *pathString = [NSString stringWithFormat:@"\n发送请求的应用程序的 Bundle ID：%@\n\n文件的NSURL：%@\n\n文件相关的属性列表对象：%@",
                         application[UIApplicationLaunchOptionsSourceApplicationKey],
                             application[UIApplicationLaunchOptionsURLKey],
                         application[UIApplicationLaunchOptionsSourceApplicationKey]];
        [YACheckData showMessageAlert:@"" message:pathString];
    }
}

+ (void)showKeyChainData:(NSArray *)array
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[array objectAtIndex:0] message:[array objectAtIndex:1] preferredStyle: UIAlertControllerStyleActionSheet];
    UIImage *userImage = (UIImage *)[array objectAtIndex:2];
    UIImageView *userInfoImageView = [[UIImageView alloc] initWithImage:userImage];
    userInfoImageView.frame = CGRectMake(10,10,alertController.view.bounds.size.width - 40,140);
    userInfoImageView.center = alertController.view.center;
//    [alertController.view addSubview:userInfoImageView];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    [keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{
        
    }];
    NSLog(@"%@",alertController.view.subviews);
}

+(void)showMessageAlert:(NSObject *)title message:(NSObject *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",title] message:[NSString stringWithFormat:@"%@",message] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{
        
    }];
    
}
@end
