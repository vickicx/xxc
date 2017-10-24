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
- (void)jumpToBigImg:(NSString *)image;

@end


@interface FindHimCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak, readonly) UILabel *label;
@property (nonatomic, strong) UILabel *signature;

@property (nonatomic, assign) id<jumpToDelegate>jumpDelegate;
@end
