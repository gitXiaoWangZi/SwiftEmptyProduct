//
//  HomeViewController.swift
//  CommoniOSFramework
//
//  Created by 刘圣洁 on 2022/8/18.
//

import UIKit

class HomeViewController: MainBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = HomeDetailViewController()
        vc.title = "详情页"
        navigationController?.pushViewController(vc, animated: true)
    }
}
