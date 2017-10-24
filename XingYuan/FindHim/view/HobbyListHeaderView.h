//
//  HobbyListHeaderView.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/20.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HobbyListHeaderView : UICollectionReusableView
@property (nonatomic,copy) NSString *title;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
@end
