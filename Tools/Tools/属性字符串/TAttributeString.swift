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

extension String {
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
        
        
}
}

    extension String {
        func range(from nsRange: NSRange) -> Range<String.Index>? {
            guard
                let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
                let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
                let from = String.Index(from16, within: self),
                let to = String.Index(to16, within: self)
                else { return nil }
            return from ..< to
        }
}


