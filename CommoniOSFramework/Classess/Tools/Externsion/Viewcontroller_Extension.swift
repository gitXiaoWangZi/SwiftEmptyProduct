//
//  Viewcontroller_Extension.swift
//  SCRM_iOS
//
//  Created by 刘圣洁 on 2022/6/14.
//

import Foundation
import UIKit

extension UIViewController {
    static var current:UIViewController? {
        let delegate  = UIApplication.shared.delegate as? AppDelegate
        var current = delegate?.window!.rootViewController
        
        while (current?.presentedViewController != nil)  {
            current = current?.presentedViewController
        }
        
        if let tabbar = current as? UITabBarController , tabbar.selectedViewController != nil {
            current = tabbar.selectedViewController
        }
        
        while let navi = current as? UINavigationController , navi.topViewController != nil  {
            current = navi.topViewController
        }
        return current
    }
}
