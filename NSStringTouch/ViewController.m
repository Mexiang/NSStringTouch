//
//  ViewController.m
//  NSStringTouch
//
//  Created by Dry on 16/9/6.
//  Copyright © 2016年 Dry. All rights reserved.
//

#import "ViewController.h"

#define kLinkValue_car    @"action1://"
#define kLinkValue_driver @"action1://"

@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // 1、NSMutableAttributedString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"《拼车搭乘协议》不可点击的文字组成部分《司机公约》"];
    //设置富文本的效果，将可点击的部分设置成链接
    [attributedString addAttribute:NSLinkAttributeName
                             value:kLinkValue_car
                             range:[[attributedString string] rangeOfString:@"《拼车搭乘协议》"]];
    [attributedString addAttribute:NSLinkAttributeName
                             value:kLinkValue_driver
                             range:[[attributedString string] rangeOfString:@"《司机公约》"]];
    NSDictionary *linkAttributes                = @{NSForegroundColorAttributeName: [UIColor redColor]};
    
    // 2、UITextView
    UITextView *textView        = [[UITextView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 100)];
    textView.linkTextAttributes = linkAttributes;
    textView.attributedText     = attributedString;
    textView.font               = [UIFont systemFontOfSize:15.0];
    textView.textAlignment      = NSTextAlignmentCenter;
    textView.editable           = NO;
    textView.delegate           = self;
    [self.view addSubview:textView];
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    //通过URL的absoluteString属性区分点击事件，并在此实现点击事件即可
    if ([URL.absoluteString isEqualToString:kLinkValue_car])
    {
        NSLog(@"拼车搭乘协议");
        return NO;
    }
    if ([URL.absoluteString isEqualToString:kLinkValue_driver])
    {
        NSLog(@"司机公约");
        return NO;
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
