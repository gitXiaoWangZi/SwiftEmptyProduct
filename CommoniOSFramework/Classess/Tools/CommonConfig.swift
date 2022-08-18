//
//  CommonConfig.swift
//  CommoniOSFramework
//
//  Created by 刘圣洁 on 2022/8/18.
//

import UIKit


// MARK: - 尺寸
///*屏幕宽度*
let kScreenWidth = UIScreen.main.bounds.size.width
///*屏幕高度*
let kScreenHeight = UIScreen.main.bounds.size.height
/// iPhone设备
let kIs_iphone = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? true : false)
////// iPhone4设备
let isIPhone4 = (max(UIScreen.main.bounds.size.width,UIScreen.main.bounds.height) < 568.0 ? true : false)
/// iPhone5设备
let isIPhone5 = (max(UIScreen.main.bounds.size.width,UIScreen.main.bounds.height) == 568.0 ? true : false)
/// iPhone6设备
let isIPhone6 = (max(UIScreen.main.bounds.size.width,UIScreen.main.bounds.height) == 667.0 ? true : false)
/// iPhone6Plus设备
let isIPhone6P = (max(UIScreen.main.bounds.size.width,UIScreen.main.bounds.height) == 736.0 ? true : false)

///*是否是X以上机型*
let kIs_iPhoneX = ((kScreenWidth >= 375.0) && (kScreenHeight >= 812.0) && (kIs_iphone))
///*状态栏高度*
let kStatusBarHeight = kIs_iPhoneX ? (44.0):(20.0)
///*状态栏和导航栏总高度*
let kNavBarAndStatusBarHeight = kIs_iPhoneX ? (88.0):(64.0)
///*底部安全区域远离高度*
let kBottomSafeHeight = kIs_iPhoneX ? (34.0):(0)
///*iPhoneX的状态栏高度差值*
let kTopBarDifHeight = kIs_iPhoneX ? (24.0):(0)
///*TabBar高度*
let kTabBarHeight = kIs_iPhoneX ? (83.0):(49.0)
///*导航条和Tabbar总高度*
let kNavAndTabHeight = (kNavBarAndStatusBarHeight + kTabBarHeight)
///*导航条高度*
let kNavHeight = 44.0



// MARK: - NotificationName/通知的宏方法
let kxxxxxxx_notification = "xxxxxxxNotification"


func kNotificationPost(name: String,object: Any?) {
    kNotificationPost(name: name, object: object, userInfo: nil)
}

func kNotificationPost(name: String,object: Any?,userInfo: [AnyHashable : Any]?) {
    NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: name), object: object,userInfo: userInfo)
}

func kNotificationAddObserver(observer: Any, selector: Selector, name: String) {
    NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name.init(rawValue: name), object: nil)
}

func kNotificationRemove(_ observer: Any) {
    NotificationCenter.default.removeObserver(observer)
}


// MARK: - URL
///基础URL
let kBaseUrl = "http://***.com/api/"
///获取信息
let kHome_GetMessageUrl = kBaseUrl + "home/***"
