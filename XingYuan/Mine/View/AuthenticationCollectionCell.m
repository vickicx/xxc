//
//  AuthenticationCollectionCell.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/27.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "AuthenticationCollectionCell.h"

@interface AuthenticationCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end
@implementation AuthenticationCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configWithKey:(NSString *)key{
    if([key isEqualToString:@"phoneauthentication"]){
        self.imgV.image = [UIImage imageNamed:@"手机认证"];
    }
    if([key isEqualToString:@"realnameauthentication"]){
        self.imgV.image = [UIImage imageNamed:@"实名认证"];
    }
    if([key isEqualToString:@"zmxyauthentication"]){
        self.imgV.image = [UIImage imageNamed:@"芝麻认证"];
    }
    if([key isEqualToString:@"buyhouseauthentication"]){
        self.imgV.image = [UIImage imageNamed:@"购房认证"];
    }
    if([key isEqualToString:@"buycarauthentication"]){
        self.imgV.image = [UIImage imageNamed:@"购车认证"];
    }
    //    @property (nonatomic,copy) NSString *phoneauthentication; //手机认证
    //    @property (nonatomic,copy) NSString *realnameauthentication; // 实名认证
    //    @property (nonatomic,copy) NSString *zmxyauthentication; // 芝麻认证
    //    @property (nonatomic,copy) NSString *buyhouseauthentication; // 购房认证
    //    @property (nonatomic,copy) NSString *buycarauthentication; // 购车认证
}

@end
