//
//  TAttributeString.swift
//  Tools
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 jyn. All rights reserved.
//

import Foundation
import UIKit
class TAttributeString {
    
    var attributeStr : NSMutableAttributedString =  NSMutableAttributedString()
    
    //设置整体的字符串
    func setString(string: String,color: UIColor, fontSize: CGFloat) -> Self {
        
        return setString(string: string, color: color, font: UIFont.systemFont(ofSize: fontSize))
    }
    
    func setString(string: String, color: UIColor, font: UIFont) -> Self {
        
        let inceptionAttStr = NSAttributedString(string: string, attributes: [NSFontAttributeName:font,NSForegroundColorAttributeName:color])
        
        attributeStr.setAttributedString(inceptionAttStr)
        
        return self
    }
}

//设置属性字符串中的 特殊显示的字符
extension TAttributeString {
    
    func height(string: String, color: UIColor) -> Self {
        let nsString = NSString(string: attributeStr.string)
        
        attributeStr.setAttributes([NSForegroundColorAttributeName:color], range: nsString.range(of: string))
        
        return self
    }
    
    func height(string: String, color: UIColor, fontSize: CGFloat) -> Self {
        
        return height(string: string, color: color, font: UIFont.systemFont(ofSize: fontSize))
    }
    
    func height(string: String, color: UIColor, font: UIFont) -> Self {
        
        let nsString = NSString(string: attributeStr.string)
        
        attributeStr.setAttributes([NSFontAttributeName:font, NSForegroundColorAttributeName:color], range: nsString.range(of: string))
        
        return self
    }
    
}



