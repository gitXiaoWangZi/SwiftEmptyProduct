//
//  Int_Extension.swift
//  SCRM_iOS
//
//  Created by 刘圣洁 on 2022/8/5.
//

extension Int {
    // MARK: - 获取某下标的值
    subscript(_ index: Int) -> Int{
        var sub: Int = 1
        
        if index > 0 {
            for _ in 0..<index {
                sub *= 10
            }
        }
        return self / sub % 10
    }
    
    func sj_ToString() -> String {
        return "\(self)"
    }
}
