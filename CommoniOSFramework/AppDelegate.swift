//
//  AppDelegate.swift
//  CommoniOSFramework
//
//  Created by 刘圣洁 on 2022/8/18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarController()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        //设置导航栏返回按钮
        configNaviBar()
        return true
    }
    
    // MARK: - 设置导航栏返回按钮
    func configNaviBar() {
        let backButtonBackgroundImage = UIImage(systemName: "chevron.lef")
        let barAppearance =
            UINavigationBar.appearance(whenContainedInInstancesOf: [MainNavigationViewController.self])
        barAppearance.backIndicatorImage = backButtonBackgroundImage
        barAppearance.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        
        //SwiftUI界面导航栏背景色修改
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

}

