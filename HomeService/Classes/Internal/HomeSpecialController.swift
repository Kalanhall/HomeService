//
//  HomeSpecialController.swift
//  HomeService
//
//  Created by Logic on 2020/3/13.
//  首页 - 特价控制器

import UIKit
import KLNavigationController
import Extensions
import SnapKit

class HomeSpecialController: UIViewController {
    
    lazy var topView: UIImageView = {
        let topView = UIImageView()
        topView.backgroundColor = UIColor.color(hexNumber: 0xFF7D25)
        topView.image = UIImage.image(named: "top", in: Bundle(for: type(of: self)))
        return topView
    }()
    
    lazy var botView: UIImageView = {
        let botView = UIImageView()
        botView.backgroundColor = UIColor.color(hexNumber: 0xFF7D25)
        botView.image = UIImage.image(named: "bot", in: Bundle(for: type(of: self)))
        return botView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        kl_barAlpha = 0
        kl_tintColor = .white
        kl_barStyle = .blackOpaque
        view.backgroundColor = UIColor.color(hexNumber: 0xF5F5F5)
        kl_titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.title = "每日特价"
        
        view.addSubview(topView)
        topView.snp_makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(102.auto())
        }
        
        view.addSubview(botView)
        botView.snp_makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(topView.snp_bottom)
            make.height.equalTo(174.auto())
        }
    }

}
