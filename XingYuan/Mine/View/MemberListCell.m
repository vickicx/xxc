//
//  MemberListCell.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/30.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MemberListCell.h"

@interface MemberListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UIImageView *sexImg;
@property (weak, nonatomic) IBOutlet UIStackView *messageContianView;

@property (weak, nonatomic) IBOutlet UILabel *introduce;    //简介

@end
@implementation MemberListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImg.layer.cornerRadius = 3;
    self.headImg.clipsToBounds = true;
    
    self.nickName.font = FONT_WITH_S(15);

    self.introduce.font = FONT_WITH_S(13);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configWithModel:(MemberModel *)model{
    [self.headImg sd_setImageWithURL:Url(model.headimg)];
    self.nickName.text = model.nickname;
    
    UIImage *sexImg;
    if(model.sex == 1){
        sexImg = [UIImage imageNamed:@"six_boy"];
    }
    if(model.sex == 2){
        sexImg = [UIImage imageNamed:@"six_girl"];
    }
    self.sexImg.image = sexImg;
    
    for(UIView *subView in self.messageContianView.subviews){
        [subView removeFromSuperview];
    }
    if(model.hl_age != nil){
        [self inputInfoLabelWith:model.hl_age];
    }
    if(model.stature != nil){
        [self inputInfoLabelWith:model.stature];
    }
    if(model.hl_constellation != nil){
        [self inputInfoLabelWith:model.hl_constellation];
    }
    if(model.hl_operatingpost != nil){
        [self inputInfoLabelWith:model.hl_constellation];
    }

    self.introduce.text = model.hl_summary;
}

- (void)inputInfoLabelWith:(NSString *)str{
    UILabel *labe = [UILabel new];
    labe.textColor = APP_THEME_COLOR;
    labe.font = FONT_WITH_S(11);
    labe.layer.cornerRadius = 2;
    labe.layer.borderWidth = 1;
    labe.layer.borderColor = RGBColor(248, 135, 162, 1).CGColor;
    labe.text = [NSString stringWithFormat:@" %@ ",str];;
    [labe sizeToFit];
    [self.messageContianView addArrangedSubview:labe];
}

@end
