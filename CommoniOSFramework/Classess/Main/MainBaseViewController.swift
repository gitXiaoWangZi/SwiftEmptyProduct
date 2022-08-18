//
//  MainBaseViewController.swift
//  CommoniOSFramework
//
//  Created by 刘圣洁 on 2022/8/18.
//
import UIKit

class MainBaseViewController: UIViewController, UIGestureRecognizerDelegate {

    ///是否隐藏页面的导航栏
    var navBarHidden : Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(navBarHidden, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //导航栏隐藏后保留右滑出屏幕的动作
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        configUI()
    }
}

//MARK:--设置UI
extension MainBaseViewController {
    
    final func configUI() {
        view.backgroundColor = UIColor(named: "globalBgColor")
        configNaviBar()
    }
    
    func configNaviBar() {
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButton
    }
}
