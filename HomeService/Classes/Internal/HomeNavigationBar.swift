//
//  HomeNavigationBar.swift
//  HomeService
//
//  Created by Logic on 2020/3/14.
//

import UIKit
import SnapKit

class HomeNavigationBar: UIView {
    
    lazy var topView = { () -> UIImageView in
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    } ()
    
    lazy var botView = { () -> UIImageView in
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    } ()
    
    lazy var leftIcon = { () -> UIImageView in
        let view = UIImageView()
        return view
    } ()
    
    lazy var searchTextF = { () -> UITextField in
        let view = UITextField()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    } ()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(topView)
        topView.snp_makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(EXTopBarHeight())
        }
        
        self.insertSubview(botView, belowSubview: topView)
        botView.snp_makeConstraints { (make) in
            make.top.equalTo(topView.snp_bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(41/*搜索栏高度*/)
        }
        
        self.addSubview(leftIcon)
        leftIcon.snp_makeConstraints { (make) in
            make.top.equalToSuperview().inset(EXStatusBarHeight() + 7/*距离状态栏底部高度*/)
            make.leading.equalTo(10)
            make.bottom.equalTo(topView.snp_bottom).inset(7)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        self.addSubview(searchTextF)
        searchTextF.snp_makeConstraints { (make) in
            make.height.equalTo(30)
            make.leading.equalTo(10)
            make.trailing.bottom.equalTo(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
