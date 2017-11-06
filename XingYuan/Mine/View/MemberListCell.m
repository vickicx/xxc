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
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *height;
@property (weak, nonatomic) IBOutlet UILabel *constelletion;    //星座
@property (weak, nonatomic) IBOutlet UILabel *Occupation;   //职业
@property (weak, nonatomic) IBOutlet UILabel *introduce;    //简介

@end
@implementation MemberListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImg.layer.cornerRadius = 3;
    self.headImg.clipsToBounds = true;
    
    self.nickName.font = FONT_WITH_S(15);
    self.age.font = FONT_WITH_S(11);
    self.height.font = FONT_WITH_S(11);
    self.constelletion.font = FONT_WITH_S(11);
    self.Occupation.font = FONT_WITH_S(11);
    self.introduce.font = FONT_WITH_S(13);
    
    self.age.layer.cornerRadius = 2;
    self.age.layer.borderWidth = 1;
    self.age.layer.borderWidth = 1;
    self.age.layer.borderColor = RGBColor(248, 135, 162, 1).CGColor;
    
    self.height.layer.cornerRadius = 2;
    self.height.layer.borderWidth = 1;
    self.height.layer.borderWidth = 1;
    self.height.layer.borderColor = RGBColor(248, 135, 162, 1).CGColor;
    
    self.constelletion.layer.cornerRadius = 2;
    self.constelletion.layer.borderWidth = 1;
    self.constelletion.layer.borderWidth = 1;
    self.constelletion.layer.borderColor = RGBColor(248, 135, 162, 1).CGColor;
    
    self.Occupation.layer.cornerRadius = 2;
    self.Occupation.layer.borderWidth = 1;
    self.Occupation.layer.borderWidth = 1;
    self.Occupation.layer.borderColor = RGBColor(248, 135, 162, 1).CGColor;
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
    
    //年龄
    if(model.hl_age == nil){
        [self.age setHidden:true];
    }else{
        [self.age setHidden:false];
        self.age.text = [NSString stringWithFormat:@" %@ ",model.hl_age];
    }
    //身高
    if(model.stature == nil){
        [self.height setHidden:true];
    }else{
        [self.height setHidden:false];
        self.height.text = [NSString stringWithFormat:@" %@ ",model.stature];
    }
    //星座
    if(model.hl_constellation == nil){
        [self.constelletion setHidden:true];
    }else{
        [self.constelletion setHidden:false];
        self.constelletion.text = [NSString stringWithFormat:@" %@ ",model.hl_constellation];
    }
    //行业
    if(model.hl_operatingpost == nil){
        [self.Occupation setHidden:true];
    }else{
        [self.Occupation setHidden:false];
        self.Occupation.text = [NSString stringWithFormat:@" %@ ",model.hl_operatingpost];
    }

    self.introduce.text = model.hl_summary;
}

@end
