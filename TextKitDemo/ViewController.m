//
//  ViewController.m
//  TextKitDemo
//
//  Created by Gray.Luo on 15/11/29.
//  Copyright © 2015年 WeiFocus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]init];
    
    //设置text
    NSString *str1 = @"Life isn’t always beautiful, but the struggles make you stronger, the changes make you wiser.";
    NSString *str2 = @"生活不一定是一直美好的，但是那些挣扎可以让你变得更坚强，那些改变可以让你变得更有智慧。";
    NSString *str3 = @"早安！星期一！";
    NSString *str4 = @"输入错误的删除线";
    
    [attriStr.mutableString appendString:str1];
    [attriStr.mutableString appendString:str2];
    [attriStr.mutableString appendString:str3];
    [attriStr.mutableString appendString:str4];
    //添加属性
    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, [str1 length])];
    [attriStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleDouble | NSUnderlinePatternDot) range:NSMakeRange([str1 length], [str2 length])];
    
    [attriStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange([str1 length]+[str2 length], [str3 length])];
    
    NSDictionary *strikeThroughAttributes = @{NSStrikethroughStyleAttributeName:@1,NSForegroundColorAttributeName:[UIColor redColor]};
    [attriStr addAttributes:strikeThroughAttributes range:NSMakeRange([str1 length]+[str2 length]+[str3 length], [str4 length])];
    
    _textView.attributedText = attriStr;
    _textView.delegate = self;
    [self setupImages];
    
    
    [self setupLinks];
    
    [self setupParagraph];

    //
    CGRect relativeRect = [_textView convertRect:_imageView.frame fromView:self.view];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:relativeRect];
    _textView.textContainer.exclusionPaths = @[path];

}


- (void)setupImages{
    NSMutableAttributedString *attriStr = [_textView.attributedText mutableCopy];
    
    NSTextAttachment *imgAttachment = [[NSTextAttachment alloc]init];
    imgAttachment.image = [UIImage imageNamed:@"emotion.gif"];
    imgAttachment.bounds = CGRectMake(0, 0, imgAttachment.image.size.width, imgAttachment.image.size.height);
    [attriStr insertAttributedString:[NSAttributedString attributedStringWithAttachment:imgAttachment] atIndex:20];
    _textView.attributedText = attriStr;
}

- (void)setupParagraph{
    NSMutableAttributedString *attriStr = [_textView.attributedText mutableCopy];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.firstLineHeadIndent = 4;//段落首行缩进
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;//换行模式
    paragraphStyle.paragraphSpacing = 20;//段落后间距
    paragraphStyle.paragraphSpacingBefore = 5;//段落前间距
    paragraphStyle.lineHeightMultiple = 1.5;//行间距多少倍
    paragraphStyle.alignment = NSTextAlignmentLeft;//对齐方式
    paragraphStyle.lineSpacing = 1;
//    paragraphStyle.headIndent = 10;//头部padding
//    paragraphStyle.tailIndent = 10;//尾部padding
    
    [attriStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attriStr.mutableString length])];
    _textView.attributedText = attriStr;
}

- (void)setupLinks{
    
    NSMutableAttributedString *attriStr = [_textView.attributedText mutableCopy];
    
    NSAttributedString *subjectStr = [[NSAttributedString alloc]initWithString:@"#早安,成都#" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont italicSystemFontOfSize:24]}];
    
    [attriStr insertAttributedString:subjectStr atIndex:0];
    
    [attriStr addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://www.baidu.com"] range:NSMakeRange(0, [subjectStr.string length])];
    
    _textView.attributedText = attriStr;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextView Delegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    NSLog(@"%@", textAttachment);
    return NO;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSLog(@"URL tap handle:%@",URL);
    [[UIApplication sharedApplication] openURL:URL];
    return YES;
}
@end
