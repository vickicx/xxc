//
//  FindHimCollectionViewCell.h
//  XingYuan
//
//  Created by 陈曦 on 2017/9/28.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol jumpToDelegate <NSObject>

- (void)jumpTOUserDetail:(NSInteger)index;
- (void)jumpToBigImg:(NSString *)image index:(NSInteger)index;

@end


@interface FindHimCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *signature;
@property (nonatomic, strong) UIButton *mainButton;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *middleButton;
@property (nonatomic, strong) UIButton *righButton;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *info;
@property (nonatomic,strong) UIImageView *sixImageView;
@property (nonatomic, assign) NSInteger index;



@property (nonatomic, assign) id<jumpToDelegate>jumpDelegate;
@end
