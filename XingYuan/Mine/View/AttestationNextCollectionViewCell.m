//
//  AttestationNextCollectionViewCell.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/23.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "AttestationNextCollectionViewCell.h"

@interface AttestationNextCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@end
@implementation AttestationNextCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nextBtn.layer.cornerRadius = 3;
    self.nextBtn.clipsToBounds = true;
    
}
- (IBAction)dealToNext:(UIButton *)sender {
    if(self.nextBlock != nil){
        self.nextBlock();
    }
}

@end
