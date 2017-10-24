//
//  FillUserInfoNoticeHeaderView.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/13.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "FillUserInfoNoticeHeaderView.h"

@interface FillUserInfoNoticeHeaderView()
@property (nonatomic,weak) UILabel *noticeLabel;
@end

@implementation FillUserInfoNoticeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        UILabel *noticeLabel = [[UILabel alloc] init];
        noticeLabel.font = FONT(14);
        noticeLabel.textColor = RGBColor(184, 186, 189, 1);
        noticeLabel.text = self.notice == nil ? @"当你完善此项资料，方可解锁其他用户的此项资料":self.notice;
        [self addSubview:noticeLabel];
        self.noticeLabel = noticeLabel;
        [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
        }];
    }
    return self;
}

- (void)setNotice:(NSString *)notice{
    _notice = notice;
    self.noticeLabel.text = notice;
}

@end
