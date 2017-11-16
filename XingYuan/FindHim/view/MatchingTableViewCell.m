//
//  MatchingTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/17.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MatchingTableViewCell.h"

@interface MatchingTableViewCell ()<UIWebViewDelegate>
@property (nonatomic, strong)  UIWebView *webView;
@end

@implementation MatchingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 1300*FitHeight)];
        
        [self addSubview:_webView];
        
        _webView.delegate = self;
        
        _webView.scalesPageToFit = YES;
        
        _webView.scrollView.bounces = NO;
        
        //加载本地html
        
//        NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"FindHim/View/matching/matching.html" withExtension:nil];
//        NSURLRequest *request = [NSURLRequest requestWithURL:filePath];
        
        //网络html
        
        
//        NSString *path = [[NSBundle mainBundle] bundlePath];
//        NSURL *baseURL = [NSURL fileURLWithPath:path];
//        NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"matching"
//                                                              ofType:@"html"];
//        NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
//                                                        encoding:NSUTF8StringEncoding
//                                                           error:nil];
//        [webView loadHTMLString:htmlCont baseURL:baseURL];
        
        
       
    }
    return self;
}

-(void)setUrl:(NSString *)url {
    if (_url != url) {
        _url = url;
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
     [_webView loadRequest:request];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
