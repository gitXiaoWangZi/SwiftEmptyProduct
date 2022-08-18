//
//  Nsstring_Externsion.swift
//  CommoniOSFramework
//
//  Created by 刘圣洁 on 2022/8/18.
//

import Foundation
import CommonCrypto

//MARK: ---加密、本地化
extension String {

    ///MD5加密
    var sj_md5 : String? {
        
        let length = Int(CC_MD5_DIGEST_LENGTH)
        
        guard let data = self.data(using: String.Encoding.utf8) else { return nil }
        
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash: [UInt8] = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return (0..<length).map { String(format: "%02x", hash[$0]) }.joined()
    }
}

//MARK: ---下标
//let str = "Hello, world"
//print(str[...4]) // "Hello"
extension String {
    ///获取该下标的字符
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    ///获取范围下标的字符串
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < start { return "" }
        return self[start..<end]
    }
    
    ///获取范围下标的字符串
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < start { return "" }
        return self[start...end]
    }
    
    ///获取范围下标的字符串
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        if end < start { return "" }
        return self[start...end]
    }
    
    ///获取范围下标的字符串
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < startIndex { return "" }
        return self[startIndex...end]
    }
    
    ///获取范围下标的字符串
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < startIndex { return "" }
        return self[startIndex..<end]
    }
}

//MARK: ---内容检查
//let a1 = "12345".containsOnlyDigits // true
extension String {
    ///是否只包含数字
    var sj_containsOnlyDigits: Bool {
        let notDigits = NSCharacterSet.decimalDigits.inverted
        return rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
    }
    
    ///是否只包含字符串
    var sj_containsOnlyLetters: Bool {
        let notLetters = NSCharacterSet.letters.inverted
        return rangeOfCharacter(from: notLetters, options: String.CompareOptions.literal, range: nil) == nil
    }
    
    ///是否同时包含字符串和数字
    var sj_isAlphanumeric: Bool {
        let notAlphanumeric = NSCharacterSet.decimalDigits.union(NSCharacterSet.letters).inverted
        return rangeOfCharacter(from: notAlphanumeric, options: String.CompareOptions.literal, range: nil) == nil
    }
}

//MARK: ---检查字符串是否是有效的电子邮件地址
//let approved = "test@test.com".isValidEmail // true
extension String {
    private func sj_matches(_ expression: String) -> Bool {
        if let range = range(of: expression, options: .regularExpression, range: nil, locale: nil) {
            return range.lowerBound == startIndex && range.upperBound == endIndex
        } else {
            return false
        }
    }
    
    var isValidEmail: Bool {
        sj_matches("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    }
}

//MARK: ---string转换成int
//"10".toInt()
extension String {
    func sj_toInt() -> Int {
        Int(self)!
    }
    
    func sj_toIntOrNull() -> Int? {
        Int(self)
    }
}

//MARK: - 将字符分组
/*  var cardNumber = "1234567890123456"
    cardNumber.insert(separator: " ", every: 4)
    print(cardNumber)
    // 1234 5678 9012 3456
*/
extension String {
    mutating func sj_insert(separator: String, every n: Int) {
        self = sj_inserting(separator: separator, every: n)
    }
    
    func sj_inserting(separator: String, every n: Int) -> String {
        var result: String = ""
        let characters = Array(self)
        stride(from: 0, to: count, by: n).forEach {
            result += String(characters[$0..<min($0+n, count)])
            if $0+n < count {
                result += separator
            }
        }
        return result
    }
}

//MARK: - 获取字符串的首字母
extension String {
    
    //获取拼音首字母（大写字母）
    func sj_firstLetter() -> String {
        //转变成可变字符串
        let mutableString = NSMutableString.init(string: self)

        //将中文转换成带声调的拼音
        CFStringTransform(mutableString as CFMutableString, nil,      kCFStringTransformToLatin, false)

        //去掉声调
        let pinyinString = mutableString.folding(options:          String.CompareOptions.diacriticInsensitive, locale:   NSLocale.current)

        //将拼音首字母换成大写
        let strPinYin = polyphoneStringHandle(nameString: self,    pinyinString: pinyinString).uppercased()

        //截取大写首字母
        let firstString = String(strPinYin[0])

        //判断首字母是否为大写
        let regexA = "^[A-Z]$"
        let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        return predA.evaluate(with: firstString) ? firstString : "#"
    }

    //多音字处理，根据需要添自行加
    func polyphoneStringHandle(nameString: String, pinyinString: String) -> String {
        if nameString.hasPrefix("长") {return "chang"}
        if nameString.hasPrefix("沈") {return "shen"}
        if nameString.hasPrefix("厦") {return "xia"}
        if nameString.hasPrefix("地") {return "di"}
        if nameString.hasPrefix("重") {return "chong"}
        return pinyinString
    }
}

//MARK: - 获取16位随机字符串
extension String {
    
    func random34String() -> String {
        randomString(length: 34)
    }
    
    func random32String() -> String {
        randomString(length: 32)
    }
    
    func randomString(length: Int) -> String {
        //ABCDEFGHIJKLMNOPQRSTUVWXYZ
        let letters : NSString = "abcdefghijklmnopqrstuvwxyz0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar,length: 1) as String
        }
        return randomString
    }
}

// MARK: - 是否为全空
extension String {
    func isAllEmptyString() -> Bool {
        for char in self {
            if char != " " {
                return false
            }
        }
        return true
    }
}
