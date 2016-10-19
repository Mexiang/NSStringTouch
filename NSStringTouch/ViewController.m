//
//  ViewController.m
//  NSStringTouch
//
//  Created by Dry on 16/9/6.
//  Copyright © 2016年 Dry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     将连接替换成文字，实现点击方法,字体的颜色是蓝色的，怎么设置字体颜色为红色呢？
     */
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"《拼车搭乘协议》不可点击的文字组成部分《司机公约》"];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"action1://"
                             range:[[attributedString string] rangeOfString:@"《拼车搭乘协议》"]];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"action2://"
                             range:[[attributedString string] rangeOfString:@"《司机公约》"]];
    NSDictionary *linkAttributes = @{NSForegroundColorAttributeName: [UIColor redColor]};
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 100)];
    textView.linkTextAttributes = linkAttributes;
    textView.attributedText = attributedString;
    textView.font = [UIFont systemFontOfSize:15.0];
    textView.textAlignment = NSTextAlignmentCenter;
    textView.editable = NO;
    textView.delegate = self;
    [textView sizeToFit];
    [self.view addSubview:textView];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
//    if ((characterRange.location == 0) && (characterRange.length == 8)) {
//        NSLog(@"拼车搭乘协议");
//    }
//    
//    if ((characterRange.location == 19) && (characterRange.length == 8)) {
//        NSLog(@"叮叮司机公约");
//    }

    if ([URL.absoluteString isEqualToString:@"action1://"]) {
    
        NSLog(@"拼车搭乘协议");
        
        return NO;
    }
    
    
    if ([URL.absoluteString isEqualToString:@"action2://"]) {
        
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
