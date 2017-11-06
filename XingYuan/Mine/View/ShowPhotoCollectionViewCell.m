//
//  ShowPhotoCollectionViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/11/1.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ShowPhotoCollectionViewCell.h"

@implementation ShowPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.imageviews = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self addSubview:self.imageviews];
        
        self.delegateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.delegateButton.frame = CGRectMake(0, 0, 20, 20);
        [self.delegateButton setTitle:@"X" forState:UIControlStateNormal];
        [self.delegateButton addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.delegateButton];
        self.delegateButton.hidden = YES;
    }
    return self;
}

- (void)deletePicture:(UIButton *)button {
    self.DeletePicBlock(button);
}

- (void)setPicModel:(PictureModel *)picModel {
    if (_picModel != picModel) {
        _picModel = picModel;
    }
    NSString *str = picModel.pic;
    
    [self.imageviews sd_setImageWithURL:[NSURL URLWithString:Url(str)] placeholderImage:[UIImage imageNamed:@"照片"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.delegateButton.hidden = NO;
    }];
   
}

- (void)setHidden:(BOOL)hidden {
    if (_isHidden != hidden) {
        _isHidden = hidden;
    }
    if (_isHidden) {
        self.delegateButton.hidden = YES;
    } else {
        self.delegateButton.hidden = NO;
    }
    
}

- (UIView *)snapshotView {
    UIView *snapshotView = [[UIView alloc]init];
    
    UIView *cellSnapshotView = nil;
    
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        cellSnapshotView = [self snapshotViewAfterScreenUpdates:NO];
    } else {
        CGSize size = CGSizeMake(self.bounds.size.width + 20, self.bounds.size.height + 20);
        UIGraphicsBeginImageContextWithOptions(size, self.opaque, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * cellSnapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cellSnapshotView = [[UIImageView alloc]initWithImage:cellSnapshotImage];
    }
    
    snapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    cellSnapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    
    [snapshotView addSubview:cellSnapshotView];
    return snapshotView;
}


@end
