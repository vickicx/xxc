//
//  Macros.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/13.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//屏幕宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//屏幕frame
#define SCREEN_RECT [UIScreen mainScreen].bounds


/**
 当设计图给的以plus系列（屏幕宽度414如，6plus、6splus、7plus）为标准时的字体大小
 
 @param plusFont 设计图给的字体大小
 @return 适配字体
 */
#define FONT_WITH_PLUS(plusFont) [Helper adaptiveFontWithPlusFont:plusFont];

/**
 当设计图给的以S系列（屏幕宽度375如，6、6s、7）为标准时的字体大小
 
 @param sFont 设计图给的字体大小
 @return 适配字体
 */
#define FONT_WITH_S(sFont)    [Helper adaptiveFontWithSFont:sFont];
#endif /* Macros_h */
