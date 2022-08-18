//
//  MainTabBarController.swift
//  CommoniOSFramework
//
//  Created by 刘圣洁 on 2022/8/18.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let HomeNav = configVC(viewController: HomeViewController(), title: "首页", image: "message", selectImageName: "message.fill")
        let MeNav = configVC(viewController: MeViewController(), title: "我的", image: "person", selectImageName: "person.fill")
        self.viewControllers = [HomeNav,MeNav]
        tabBar.tintColor = UIColor.systemBlue
        tabBar.backgroundColor = UIColor.systemBackground
        selectedIndex = 0
    }
    

    func configVC(viewController: UIViewController, title: String, image: String, selectImageName: String) -> MainNavigationViewController{
        let navigationController = MainNavigationViewController(rootViewController: viewController)
        viewController.title = title
        navigationController.tabBarItem.image = UIImage(systemName: image)//.withRenderingMode(.alwaysOriginal)
        navigationController.tabBarItem.selectedImage = UIImage(systemName: selectImageName)//.withRenderingMode(.alwaysOriginal)
        navigationController.navigationBar.backgroundColor = UIColor.systemBackground
        return navigationController
    }
    
    deinit {
        print("MainTabBarController注销")
    }
}
