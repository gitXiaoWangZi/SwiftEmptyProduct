//
//  UIColor_Externsion.swift
//  CommoniOSFramework
//
//  Created by 刘圣洁 on 2022/8/18.
//

import UIKit

extension UIColor {
    
    ///生成随机色
    class var sj_random: UIColor {
        return UIColor(r: arc4random_uniform(256),
                       g: arc4random_uniform(256),
                       b: arc4random_uniform(256))
    }
    
    ///class 声明一个类属性
    class var sj_theme_color: UIColor {
        return UIColor.sj_HexColor(hex: "EE7942")
    }
    
    class var sj_themeText_color: UIColor {
        return UIColor(r: 27, g: 221, b: 142)
    }
    
    ///<Auto:统一的导航栏白色背景色 Light:#FFFFFF  dark:#1C1C1C
    class var sj_whiteNavBg_color:UIColor {
        return sj_AutoFitHexColor(lightHex: "#FFFFFF", darkHex: "#1C1C1C")
    }
    
    ///<Auto:白色TabBar背景色 systemGray5
    class var sj_whiteTabBarBg_color:UIColor {
        return UIColor.systemGray5
    }
    
    ///<Auto:白色背景色 systemGray6
    class var sj_whiteBg_color:UIColor {
        return UIColor.systemGray6
    }
    
}

//扩展UIColor
extension UIColor {
    
    convenience init(r:UInt32 ,g:UInt32 , b:UInt32 , a:CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: a)
    }
    
    //生成纯色图片
    func sj_image() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    ///从十六进制字符串获取颜色，
    ///color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
    class func sj_hex(hexString: String) -> UIColor {
        return UIColor.sj_hex(hexString: hexString, alpha: 1.0)
    }
    
    ///从十六进制字符串获取颜色，
    ///color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
    class func sj_hex(hexString: String, alpha:CGFloat) -> UIColor {
        //删除字符串中的空格
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // String should be 6 or 8 characters
        if cString.count < 6 { return UIColor.clear}
        
        // strip 0X if it appears
        //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
        let index = cString.index(cString.endIndex, offsetBy: -6)
        let subString = cString[index...]
        if cString.hasPrefix("0X") { cString = String(subString) }
        //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
        if cString.hasPrefix("#") { cString = String(subString) }
        
        if cString.count != 6 { return UIColor.clear }
        // Separate into r, g, b substrings
        var range: NSRange = NSMakeRange(0, 2)
        //r
        let rString = (cString as NSString).substring(with: range)
        
        //g
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        //b
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        // Scan values
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(r: r, g: g, b: b, a:alpha)
    }
    
    ///从十六进制字符串获取颜色，
    ///color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
    class func sj_HexColor(hex:String,alpha:CGFloat = 1.0) -> UIColor {
        return UIColor.sj_hex(hexString: hex, alpha: alpha)
    }
    
    ///返回根据当前显示模式的color
    class func sj_AutoFitHexColor(lightHex:String, darkHex:String) -> UIColor {
        if #available(iOS 13.0, *){
            let color = UIColor.init{trainCollection -> UIColor in
                if trainCollection.userInterfaceStyle == UIUserInterfaceStyle.dark{
                    return UIColor.sj_hex(hexString: darkHex)
                }else {
                    return UIColor.sj_hex(hexString: lightHex)
                }
            }
            return color
        }else {
            return UIColor.sj_hex(hexString: lightHex)
        }
    }
    
    ///返回根据当前模式的color
    class func sj_AutoFitColor(lightColor:UIColor, darkColor:UIColor) -> UIColor {
        if #available(iOS 13.0, *){
            let color = UIColor.init{trainCollection -> UIColor in
                if trainCollection.userInterfaceStyle == UIUserInterfaceStyle.dark{
                    return darkColor
                }else {
                    return lightColor
                }
            }
            return color
        }else {
            return lightColor
        }
    }
    
}
