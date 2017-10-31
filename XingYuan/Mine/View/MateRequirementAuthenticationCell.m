//
//  MateRequirementAuthenticationCell.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/27.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MateRequirementAuthenticationCell.h"
#import "AuthenticationCollectionCell.h"

@interface MateRequirementAuthenticationCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *redPoint;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;

@property (strong,nonatomic) NSArray *keys;
@end
@implementation MateRequirementAuthenticationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.editBtn.layer.cornerRadius = 3;
    self.editBtn.clipsToBounds = true;
    self.editBtn.layer.borderColor = RGBColor(246, 80, 118, 1).CGColor;
    
    self.redPoint.layer.cornerRadius = 3;
    self.redPoint.clipsToBounds = true;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"AuthenticationCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"AuthenticationCollectionCell"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = true;
    self.collectionView.layer.cornerRadius = 3;
    self.collectionView.clipsToBounds = true;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumInteritemSpacing:10];
    [layout setMinimumLineSpacing:10];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)configWithModel:(ThreeStageScreeningModel *)model{
    NSMutableArray *keys = [NSMutableArray new];
    if(model.phoneauthentication){
        [keys addObject:@"phoneauthentication"];
    }
    if(model.realnameauthentication){
        [keys addObject:@"realnameauthentication"];
    }
    if(model.zmxyauthentication){
        [keys addObject:@"zmxyauthentication"];
    }
    if(model.buyhouseauthentication){
        [keys addObject:@"buyhouseauthentication"];
    }
    if(model.buycarauthentication){
        [keys addObject:@"buycarauthentication"];
    }
    self.keys = keys;
    [self.collectionView reloadData];
//    @property (nonatomic,assign) BOOL phoneauthentication; //手机认证
//    @property (nonatomic,assign) BOOL realnameauthentication; // 实名认证
//    @property (nonatomic,assign) BOOL zmxyauthentication; // 芝麻认证
//    @property (nonatomic,assign) BOOL buyhouseauthentication; // 购房认证
//    @property (nonatomic,assign) BOOL buycarauthentication; // 购车认证
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
    return self.keys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AuthenticationCollectionCell *authenticationCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AuthenticationCollectionCell" forIndexPath:indexPath];
    [authenticationCollectionCell configWithKey:self.keys[indexPath.row]];
    return authenticationCollectionCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    UIImage *img = [UIImage imageNamed:@"芝麻认证"];
    return img.size;
}

@end
