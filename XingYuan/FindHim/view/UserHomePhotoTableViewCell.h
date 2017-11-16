//
//  UserHomePhotoTableViewCell.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/9.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmallPhotoCollectionViewCell.h"


@interface UserHomePhotoTableViewCell : UITableViewCell<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) void(^toBlock)(NSArray *dataSource, NSInteger tag);
@property (nonatomic,copy) NSString *photoNum1;
@property (nonatomic,strong) NSMutableArray *picArr;



@end
