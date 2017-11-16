//
//  UserHomePhotoTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/9.
//  Copyright © 2017年 Vicki. All rights reserved.
//



#import "UserHomePhotoTableViewCell.h"
#import "PictureModel.h"

@interface UserHomePhotoTableViewCell()
@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic, strong) UILabel *photoNum;


@end

@implementation UserHomePhotoTableViewCell

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
        
        UILabel *photo = [[UILabel alloc] initWithFrame:CGRectMake(dian.right + 10 * FitWidth, 15 * FitHeight, 80*FitWidth, 30*FitHeight)];
        photo.text = @"他的相册";
        photo.font = FONT_WITH_S(16);
        
        [self addSubview:photo];
        
        _photoNum = [[UILabel alloc] initWithFrame:CGRectMake(photo.right, 15 * FitHeight, 70*FitWidth, 30*FitHeight)];
       
        _photoNum.font = FONT_WITH_S(14);
        _photoNum.textColor = [UIColor colorWithRed:141/255.0 green:146/255.0 blue:149/255.0 alpha:1];
        [self addSubview:_photoNum];
        
        
        UILabel *kong1 = [[UILabel alloc] initWithFrame:CGRectMake(12*FitWidth, photo.bottom + 10 * FitHeight, kWIDTH - 24 * FitWidth, 1 *FitHeight)];
        kong1.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        [self addSubview:kong1];

        
        
        
        
        _flowLayout = [UICollectionViewFlowLayout new]; // 自定义的布局对象
        _flowLayout.itemSize = CGSizeMake(81*FitWidth, 81*FitHeight);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 10;
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kong1.bottom + 10 * FitHeight, kWIDTH, 100*FitHeight) collectionViewLayout:_flowLayout];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.dataSource = self;
        _collection.delegate = self;
        _collection.bounces = NO;
        _collection.showsVerticalScrollIndicator = NO;
        _collection.showsHorizontalScrollIndicator = NO;
        
        [_collection registerNib:[UINib nibWithNibName:@"SmallPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SmallPhotoCollectionViewCell"];
        
        [self addSubview:_collection];
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoNum1.intValue;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section

{
    
    return UIEdgeInsetsMake(0, 11*FitHeight, 0, 0);
    
}





- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SmallPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SmallPhotoCollectionViewCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 5.0f;
    cell.imageView.layer.cornerRadius = 5.0f;
    PictureModel *pic = self.picArr[indexPath.row];
    [cell.imageView sd_setImageWithURL:Url(pic.pic) placeholderImage:[UIImage imageNamed:@"照片"]];
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *mutableArray = [NSMutableArray new];
    
    for (int i = 0; i < self.picArr.count; i++) {
        NSIndexPath *indexPaths = [NSIndexPath indexPathForItem:i inSection:0];
//        SmallPhotoCollectionViewCell *cell = (SmallPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        PictureModel *pic = self.picArr[indexPaths.row];
        UIImageView *imageView = [UIImageView new];
        [imageView sd_setImageWithURL:Url(pic.pic) placeholderImage:[UIImage imageNamed:@"照片"]];
        [mutableArray addObject:imageView.image];
    }
    self.imageArray = [NSArray arrayWithArray:mutableArray];
    
    self.toBlock(self.imageArray, indexPath.row);
   
}

-(void)setPicArr:(NSMutableArray *)picArr {
    if (_picArr != picArr) {
        _picArr = picArr;
    }
    self.photoNum1 = [NSString stringWithFormat:@"%ld",picArr.count];
     _photoNum.text = [NSString stringWithFormat:@"(%@)",self.photoNum1];
}







@end
