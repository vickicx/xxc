//
//  AddNewPhotoCollectionViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/11/1.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "AddNewPhotoCollectionViewCell.h"

@implementation AddNewPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
        self.imageviews = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageviews.image = [UIImage imageNamed:@"addimage"];
        [self addSubview:self.imageviews];
    }
    return self;
}

@end
