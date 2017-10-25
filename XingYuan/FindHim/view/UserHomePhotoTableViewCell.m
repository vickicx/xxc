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
        dian.frame = CGRectMake(12 * FitWidth, kong.bottom + 17 * FitHeight, 5, 5);
        [dian setImage:[UIImage imageNamed:@"椭圆"]];
        [self addSubview:dian];
        
        UILabel *photo = [[UILabel alloc] initWithFrame:CGRectMake(dian.right + 10 * FitWidth, 15 * FitHeight, 70, 30)];
        photo.text = @"他的相册";
        photo.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:photo];
        if (self.photoNum == nil) {
            self.photoNum = @"12";
        }
        UILabel *photoNum = [[UILabel alloc] initWithFrame:CGRectMake(photo.right, 15 * FitHeight, 70, 30)];
        photoNum.text = [NSString stringWithFormat:@"(%@)",self.photoNum];
        photoNum.font = [UIFont systemFontOfSize:14];
        photoNum.textColor = [UIColor colorWithRed:141/255.0 green:146/255.0 blue:149/255.0 alpha:1];
        [self addSubview:photoNum];
        
        
        UILabel *kong1 = [[UILabel alloc] initWithFrame:CGRectMake(12, photo.bottom + 10 * FitHeight, kWIDTH - 24 * FitWidth, 1 *FitHeight)];
        kong1.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        [self addSubview:kong1];

        
        
        
        
        _flowLayout = [UICollectionViewFlowLayout new]; // 自定义的布局对象
        _flowLayout.itemSize = CGSizeMake(81, 81);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 10;
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kong1.bottom + 10 * FitHeight, kWIDTH, 100) collectionViewLayout:_flowLayout];
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
    return self.photoNum.intValue;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section

{
    
    return UIEdgeInsetsMake(0, 11, 0, 0);
    
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







@end
