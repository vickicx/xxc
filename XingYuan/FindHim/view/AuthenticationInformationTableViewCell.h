//
//  AuthenticationInformationTableViewCell.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/10.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CertificationCollectionViewCell.h"
#import "ThreeStageScreeningModel.h"

@interface AuthenticationInformationTableViewCell : UITableViewCell<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) ThreeStageScreeningModel *matchingLevelThreeModel;


@end
