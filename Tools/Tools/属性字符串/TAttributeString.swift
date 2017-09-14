//
//  TAttributeString.swift
//  Tools
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 jyn. All rights reserved.
//

import Foundation
import UIKit

enum TAttributeLocation {
    case first //只高亮第一个
    case last   //只高亮最后一个
    case all    //高亮全部
    case index(Int) //下标字符串高亮,index从0开始
}

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
    
    func highlight(string: String, color: UIColor, fontSize: CGFloat, location: TAttributeLocation = .all) -> Self {
        
        return highlight(string: string, color: color, font: UIFont.systemFont(ofSize: fontSize), location:location)
    }
    
    func highlight(string: String, color: UIColor, font: UIFont, location: TAttributeLocation = .all) -> Self {
        
        let rangeArr = ranges(ofString: string)
        if (rangeArr.count == 0) { return self }
        switch location {
        case .first:
            attributeStr.setAttributes([NSFontAttributeName:font, NSForegroundColorAttributeName:color], range: rangeArr[0])
            break
        case .last:
            attributeStr.setAttributes([NSFontAttributeName:font, NSForegroundColorAttributeName:color], range: rangeArr.last!)
            break
        case .all:
            for range in rangeArr {
                attributeStr.setAttributes([NSFontAttributeName:font, NSForegroundColorAttributeName:color], range: range)
            }
            break
        case .index(let index):
            for (arrIndex, range) in rangeArr.enumerated() {
                if arrIndex == index {
                    attributeStr.setAttributes([NSFontAttributeName:font, NSForegroundColorAttributeName:color], range: range)
                }
            }
            break
            
        }
        
        return self
    }
    
    func ranges(ofString subString: String) -> [NSRange] {
        var arr : [NSRange] = [NSRange]()
        let nsString = NSString(string: attributeStr.string)
        while true {
            let lastRange = arr.last ?? NSMakeRange(0, 0)
            let searchRange = NSMakeRange(lastRange.location + lastRange.length, nsString.length - lastRange.location - lastRange.length - 1)
            let range = nsString.range(of: subString, range: searchRange)
            if range.location != NSNotFound {
                arr.append(range)
            }else {
                return arr
            }
        }
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


