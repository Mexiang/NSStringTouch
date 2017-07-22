
# 富文本字体点击效果实现

有时候我们会看到有这样的功能，某一个字符串中有个部分是可以点击的，而且要实现点击方法，其他部分又是不可点击。我们用NSMutableAttributedString和UITextView的配合来实现这个功能。实现的效果如下图：

![show-1.png](http://upload-images.jianshu.io/upload_images/2056220-fdbb55c121257e4c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

其中红色字体是可点击的，而且需要区分点击事件实现各自的点击方法，中间黑色字体是不能点击的，下面是实现思路。

## 初始化NSMutableAttributedString
```
// 1、NSMutableAttributedString
NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"《拼车搭乘协议》不可点击的文字组成部分《司机公约》"];
//设置富文本的效果，将可点击的部分设置成链接
[attributedString addAttribute:NSLinkAttributeName
                         value:kLinkValue_car  //第一个可点击的部分
                         range:[[attributedString string] rangeOfString:@"《拼车搭乘协议》"]];
[attributedString addAttribute:NSLinkAttributeName
                         value:kLinkValue_driver//第二个可点击的部分
                         range:[[attributedString string] rangeOfString:@"《司机公约》"]];
NSDictionary *linkAttributes                = @{NSForegroundColorAttributeName: [UIColor redColor]};
```
## 创建一个UITextView
```
// 2、UITextView
UITextView *textView        = [[UITextView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 100)];
textView.linkTextAttributes = linkAttributes;
textView.attributedText     = attributedString;
textView.font               = [UIFont systemFontOfSize:15.0];
textView.textAlignment      = NSTextAlignmentCenter;
textView.editable           = NO;
textView.delegate           = self;
[self.view addSubview:textView];
```
其中使用了两个宏
```
#define kLinkValue_car    @"action1://"
#define kLinkValue_driver @"action1://"
```
## 实现textView的代理
```
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    //通过URL的absoluteString属性区分点击事件，并在此实现点击事件即可
    if ([URL.absoluteString isEqualToString:kLinkValue_car])
    {   //实现“拼成达成协议”的点击方法
        NSLog(@"拼车搭乘协议");
        return NO;
    }
    if ([URL.absoluteString isEqualToString:kLinkValue_driver])
    {  //实现“司机公约”的点击方法
        NSLog(@"司机公约");
        return NO;
    }
    return YES;
}
```
但是要注意的是，iOS低版本的系统，设置点击字体颜色是无效的，默认是蓝色的，高一点的版本就可以自己设置颜色了。

