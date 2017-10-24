//
//  NSString+tool.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/17.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "NSString+tool.h"

@implementation NSString (tool)
- (CGRect)getRectWithFont:(UIFont *)font width:(CGFloat)width{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
    CGSize size = CGSizeMake(width, 1000);
    CGRect rect = [self boundingRectWithSize:size options:options attributes:attributes context:nil];
    return rect;
}

//    func doubleValue()->Double?{
//        let nsString = NSString.init(string: self)
//        return nsString.doubleValue
//    }
//
//    // 设置字符串字体大小
//    func setStringAttributeFont(alterStr: String, size alterStrFontSize: CGFloat)->NSAttributedString {
//        let tempStr = self + alterStr
//        let length1 = (alterStr as NSString).length
//        let length2 = (self as NSString).length
//        let strAttrbute = NSMutableAttributedString(string: tempStr)
//        let range = NSRange(location: length2, length: length1)
//        strAttrbute.addAttribute(NSFontAttributeName, value: FONT(sizePlus: alterStrFontSize), range: range)
//
//        return strAttrbute
//    }
//
//    func intValue()->Int{
//        let nsString = NSString.init(string: self)
//        return Int(nsString.intValue)
//    }

@end
