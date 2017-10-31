//
//  AuthenticationInformationTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/10.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "AuthenticationInformationTableViewCell.h"



@implementation AuthenticationInformationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *kong = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 10 *FitHeight)];
        kong.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
        [self addSubview:kong];
        
        UIImageView *dian = [[UIImageView alloc] init];
        dian.frame = CGRectMake(12 * FitWidth, kong.bottom + 17 * FitHeight, 5*FitWidth, 5*FitHeight);
        [dian setImage:[UIImage imageNamed:@"椭圆"]];
        [self addSubview:dian];
        
        UILabel *Authentication = [[UILabel alloc] initWithFrame:CGRectMake(dian.right + 10 * FitWidth, 15 * FitHeight, 80*FitWidth, 30*FitHeight)];
        Authentication.text = @"认证资料";
        Authentication.font = FONT_WITH_S(16);
        
        [self addSubview:Authentication];
        
        
        UILabel *kong1 = [[UILabel alloc] initWithFrame:CGRectMake(12*FitWidth, Authentication.bottom + 10 * FitHeight, kWIDTH - 24 * FitWidth, 1 *FitHeight)];
        kong1.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        [self addSubview:kong1];
        
        
        
        
        
        _flowLayout = [UICollectionViewFlowLayout new]; // 自定义的布局对象
        _flowLayout.itemSize = CGSizeMake(110, 120);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 10;
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kong1.bottom + 10 * FitHeight, kWIDTH, 140*FitHeight) collectionViewLayout:_flowLayout];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.dataSource = self;
        _collection.delegate = self;
        _collection.bounces = NO;
        _collection.showsVerticalScrollIndicator = NO;
        _collection.showsHorizontalScrollIndicator = NO;
        
         [_collection registerNib:[UINib nibWithNibName:@"CertificationCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CertificationCollectionViewCell"];
        
        [self addSubview:_collection];
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section

{
    
    return UIEdgeInsetsMake(0, 11*FitHeight, 0, 0);
    
}





- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     CertificationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CertificationCollectionViewCell" forIndexPath:indexPath];
    NSArray *imageName = @[@"实名认证", @"手机认证", @"芝麻认证", @"购车认证", @"购房认证"];
    NSArray *imageName1 = @[@"实名认证1", @"手机认证1", @"芝麻认证1", @"购车认证1", @"购房认证1"];
    NSArray *titleName = @[@"实名认证", @"手机认证", @"芝麻认证", @"购车认证", @"购房认证"];
    cell.label.text = titleName[indexPath.row];
    if (_matchingLevelThreeModel.realnameauthentication && indexPath.row == 0) {
        [cell.imageView setImage:[UIImage imageNamed:imageName[indexPath.row]]];
    }else {
        [cell.imageView setImage:[UIImage imageNamed:imageName1[indexPath.row]]];
    }
    if (_matchingLevelThreeModel.phoneauthentication && indexPath.row == 1) {
        [cell.imageView setImage:[UIImage imageNamed:imageName[indexPath.row]]];
    }else {
        [cell.imageView setImage:[UIImage imageNamed:imageName1[indexPath.row]]];
    }
    if (_matchingLevelThreeModel.zmxyauthentication && indexPath.row == 2) {
        [cell.imageView setImage:[UIImage imageNamed:imageName[indexPath.row]]];
    }else {
        [cell.imageView setImage:[UIImage imageNamed:imageName1[indexPath.row]]];
    }
    if (_matchingLevelThreeModel.buycarauthentication && indexPath.row == 3) {
        [cell.imageView setImage:[UIImage imageNamed:imageName[indexPath.row]]];
    }else {
        [cell.imageView setImage:[UIImage imageNamed:imageName1[indexPath.row]]];
    }
    if (_matchingLevelThreeModel.buyhouseauthentication && indexPath.row == 4) {
        [cell.imageView setImage:[UIImage imageNamed:imageName[indexPath.row]]];
    }else {
        [cell.imageView setImage:[UIImage imageNamed:imageName1[indexPath.row]]];
    }
    
    return cell;
}

-(void)setMatchingLevelThreeModel:(ThreeStageScreeningModel *)matchingLevelThreeModel {
    if (_matchingLevelThreeModel != matchingLevelThreeModel) {
        _matchingLevelThreeModel = matchingLevelThreeModel;
    }
    
    [_collection reloadData];
}


@end
