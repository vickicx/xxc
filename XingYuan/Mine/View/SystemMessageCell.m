//
//  SystemMessageCell.m
//  XingYuan
//
//  Created by YunKuai on 2017/11/1.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "SystemMessageCell.h"

@interface SystemMessageCell()
@property (weak, nonatomic) IBOutlet UILabel *msgTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgDescription;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation SystemMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.msgTitleLabel.font = FONT_WITH_S(16);
    self.msgDescription.font = FONT_WITH_S(14);
    self.timeLabel.font = FONT_WITH_S(12);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configWithModel:(SystemMessageModel *)model{
    self.msgTitleLabel.text = model.title;
    self.msgDescription.text = model.content;
    self.timeLabel.text = model.time;
//    @property (nonatomic,assign) NSInteger Id; //标识ID
//    @property (nonatomic,assign) NSInteger msgtype; //消息类型，枚举
//    @property (nonatomic,copy) NSString *title; //标题
//    @property (nonatomic,copy) NSString *content; //内容
//    @property (nonatomic,assign) BOOL isread; //是否阅读
//    @property (nonatomic,copy) NSString *time; //发布时间
}
@end
