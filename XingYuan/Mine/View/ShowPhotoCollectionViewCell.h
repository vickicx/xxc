//
//  ShowPhotoCollectionViewCell.h
//  XingYuan
//
//  Created by 陈曦 on 2017/11/1.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureModel.h"


@protocol DeletePicDelegate<NSObject>

- (void)deletePicAtIndex:(NSInteger)index;

@end


@interface ShowPhotoCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView * imageviews;
@property (strong, nonatomic) PictureModel * picModel;
@property (assign, nonatomic) id<DeletePicDelegate>delegate;
@property (copy, nonatomic) void(^DeletePicBlock)(UIButton *sender);
@property (strong, nonatomic) UIButton * delegateButton;
@property (assign, nonatomic) BOOL isHidden;

- (UIView *)snapshotView;

@end
