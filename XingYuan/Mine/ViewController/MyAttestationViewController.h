//
//  MyAttestationViewController.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/14.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _AttestationControllerType {
    AttestationControllerTypeNone,
    AttestationControllerTypeScreening
}AttestationControllerType;

@interface MyAttestationViewController : UIViewController
- (instancetype)initWithType:(AttestationControllerType)type;
@end
