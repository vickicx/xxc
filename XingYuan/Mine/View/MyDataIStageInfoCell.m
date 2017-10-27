//
//  MyDataIStageInfoCell.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/17.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MyDataIStageInfoCell.h"
#import "MyDataStageItemInfoCell.h"
#import "NSString+tool.h"

@interface MyDataIStageInfoCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *redPoint;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;

@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) UIColor *color;
@end
@implementation MyDataIStageInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.editBtn.layer.cornerRadius = 3;
    self.editBtn.clipsToBounds = true;
    self.editBtn.layer.borderColor = RGBColor(246, 80, 118, 1).CGColor;
    
    self.redPoint.layer.cornerRadius = 3;
    self.redPoint.clipsToBounds = true;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyDataStageItemInfoCell" bundle:nil] forCellWithReuseIdentifier:@"MyDataStageItemInfoCell"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = false;
    self.collectionView.layer.cornerRadius = 3;
    self.collectionView.clipsToBounds = true;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumInteritemSpacing:10];
    [layout setMinimumLineSpacing:10];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    DDLogInfo(@"MyDataIStageInfoCell->awakeFromNib");
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setLeftLabelTitle:(NSString *)leftLabelTitle{
    _leftLabelTitle = leftLabelTitle;
    self.leftLabel.text = leftLabelTitle;
}

- (void)configWithTitles:(NSArray *)titles color:(UIColor *)color{
    DDLogInfo(@"MyDataIStageInfoCell->configWithTitles:%lu",(unsigned long)titles.count);
    self.titles = titles;
    self.color = color;
    [self.collectionView reloadData];
    self.collectionViewHeight.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)dealToEdit:(UIButton *)sender {
    if(self.editBlock != nil){
        self.editBlock();
    }
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyDataStageItemInfoCell *myDataStageItemInfoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyDataStageItemInfoCell" forIndexPath:indexPath];
    [myDataStageItemInfoCell configWithTitle:self.titles[indexPath.row] backgroundColor:self.color];
    return myDataStageItemInfoCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = self.titles[indexPath.row];
    CGRect rect = [title getRectWithFont:[UIFont systemFontOfSize:17] width:1000];
    return CGSizeMake(rect.size.width, rect.size.height);
}

@end
