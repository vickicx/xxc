//
//  PhotoDetailViewController.h
//  XingYuan
//
//  Created by 陈曦 on 2017/11/3.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoDetailViewController : UICollectionViewController

@property (strong, nonatomic) NSArray *dataSource;
@property (assign, nonatomic) NSInteger tag;


@end
