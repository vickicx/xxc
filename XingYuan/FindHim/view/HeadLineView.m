//
//  HeadLineView.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/9.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "HeadLineView.h"


//颜色
#define JXColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
@interface HeadLineView()
{
    UIButton *currentSelected;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    //按钮的数据
    NSMutableArray * buttonArray;
}
@end
@implementation HeadLineView
-(instancetype)init
{
    if (self=[super init]) {
        
        buttonArray=[[NSMutableArray alloc]init];
    }
    return self;
}
//传入currentIndex
-(void)setCurrentIndex:(NSInteger)CurrentIndex
{
    _CurrentIndex=CurrentIndex;//改变currentIndex
    [self shuaxinJiemian:_CurrentIndex];
    if ([_delegate respondsToSelector:@selector(refreshHeadLine:)]) {
        [_delegate refreshHeadLine:_CurrentIndex];
    }
}
//刷新界面
-(void)shuaxinJiemian:(NSInteger)index;
{
    if (buttonArray.count>0) {//防止没创建前为空
        for (UIButton *labelView in buttonArray) {
            if (labelView.tag==index) {
                if (labelView.tag==0) {
                    //深绿线
                    label1.backgroundColor=RGBColor(240, 53, 99, 1);
                }else if(labelView.tag==1){
                    label2.backgroundColor=RGBColor(240, 53, 99, 1);
                }else{
                    label3.backgroundColor=RGBColor(240, 53, 99, 1);
                }
                currentSelected=labelView;
            }else{
                if (labelView.tag==0) {
                    //绿线
                    label1.backgroundColor=RGBColor(240, 53, 99, 0.3);
                }else if(labelView.tag==1){
                    label2.backgroundColor=RGBColor(240, 53, 99, 0.3);
                }else{
                    label3.backgroundColor=RGBColor(240, 53, 99, 0.3);
                }
            }
        }
    }
}
//按钮点击 传入代理
-(void)buttonClick:(UIButton*)button
{
    NSInteger viewTag=[button tag];
    if ([button isEqual:currentSelected]) {
        return;
    }
    _CurrentIndex=viewTag;
    [self shuaxinJiemian:_CurrentIndex];
    if ([_delegate respondsToSelector:@selector(refreshHeadLine:)]) {
        [_delegate refreshHeadLine:_CurrentIndex];
    }
}

//传入顶部的title
-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray=titleArray;
    UIButton * btn=NULL;
    CGFloat width=kWIDTH/_titleArray.count;
    for (int i=0; i<_titleArray.count; i++) {
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(i*width, 0, width, 48*FitHeight);
        btn.tag=i;
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment=NSTextAlignmentCenter;
        btn.titleLabel.font=[UIFont systemFontOfSize:15.0f];
        [btn setTitleColor:RGBColor(240, 53, 99, 1) forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        
        //btn.contentEdgeInsets = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>);
        //        [btn setTitleEdgeInsets:UIEdgeInsetsMake(28, 0, 0, 34)];
        //        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 0)];
        [btn setUserInteractionEnabled:YES];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArray addObject:btn];
        [self addSubview:btn];
        if (i==0) {
            currentSelected=btn;
            //深绿线
            label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 45.5*FitHeight, kWIDTH/3, 2.5*FitHeight)];
            label1.backgroundColor=RGBColor(240, 53, 99, 1);
            [self addSubview:label1];
            //如果需要添加图片，请把注释去掉就可以了
            //            [btn setTitleColor:JXColor(87, 173, 104, 1) forState:UIControlStateNormal];
            //            [btn setBackgroundColor:[UIColor whiteColor]];
            //[btn setImage:[UIImage imageNamed:@"ribbon-pressed@2x.png"] forState:UIControlStateNormal];
        }else if(i == 1){
            //绿线
            label2=[[UILabel alloc]initWithFrame:CGRectMake(width, 45.5*FitHeight, kWIDTH/3, 2.5*FitHeight)];
            label2.backgroundColor=RGBColor(240, 53, 99, 0.3);
            [self addSubview:label2];
            //            [btn setTitleColor:JXColor(155, 155, 155, 1) forState:UIControlStateNormal];
            //            [btn setBackgroundColor:[UIColor whiteColor]];
            //[btn setImage:[UIImage imageNamed:@"bag@2x.png"] forState:UIControlStateNormal];
        }else{
            //绿线
            label3=[[UILabel alloc]initWithFrame:CGRectMake(width * 2, 45.5*FitHeight, kWIDTH/3, 2.5*FitHeight)];
            label3.backgroundColor=RGBColor(240, 53, 99, 0.3);
            [self addSubview:label3];
        }
    }
}


@end
