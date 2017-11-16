//
//  PhotoDetailCollectionViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/11/3.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PhotoDetailCollectionViewCell.h"

@implementation PhotoDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor blackColor];
        self.imageviews = [[UIImageView alloc] init];
        self.imageviews.center = CGPointMake(kWIDTH / 2, kHEIGHT /2);
        self.imageviews.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageviews];
    }
    return self;
}

- (void)setImages:(UIImage *)images {
    if (_images != images) {
        _images = images;
    }
    CGSize size = images.size;
    
    self.imageviews.image = images;
//    self.imageviews.size = CGSizeMake(kWIDTH, );
    self.imageviews.frame = CGRectMake(0, kHEIGHT / 2 - (kWIDTH * (size.height / size.width))/2, kWIDTH, kWIDTH * (size.height / size.width));
}

@end
