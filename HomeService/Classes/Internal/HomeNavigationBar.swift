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
        view.contentMode = .scaleToFill
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
    } ()
    
    lazy var botView = { () -> UIImageView in
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
    } ()
    
    lazy var leftIcon = { () -> UIImageView in
        let view = UIImageView()
        view.image = UIImage.image(named: "navleft", in: Bundle(for: HomeNavigationBar.self))
        view.clipsToBounds = true
        return view
    } ()
    
    lazy var msg = { () -> UIButton in
        let view = UIButton(type: .custom)
        view.setImage(UIImage.image(named: "navmsg", in: Bundle(for: HomeNavigationBar.self)), for: .normal)
        return view
    } ()
    
    lazy var scan = { () -> UIButton in
        let view = UIButton(type: .custom)
        view.setImage(UIImage.image(named: "navscan", in: Bundle(for: HomeNavigationBar.self)), for: .normal)
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
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(41/*搜索栏高度*/)
        }
        
        topView.addSubview(leftIcon)
        leftIcon.snp_makeConstraints { (make) in
            make.leading.equalTo(10)
            make.centerY.equalToSuperview().inset(EXStatusBarHeight() * 0.5)
        }
        
        topView.addSubview(msg)
        msg.snp_makeConstraints { (make) in
            make.trailing.equalTo(-5)
            make.top.equalTo(EXStatusBarHeight())
            make.bottom.equalToSuperview()
            make.width.equalTo(34)
        }
        
        topView.addSubview(scan)
        scan.snp_makeConstraints { (make) in
            make.width.height.centerY.equalTo(msg)
            make.right.equalTo(msg.snp_left).inset(-6)
        }
        
        self.addSubview(searchTextF)
        searchTextF.snp_makeConstraints { (make) in
            make.height.equalTo(30)
            make.leading.equalTo(10)
            make.bottom.equalTo(-11)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollDidScroll(_ scrollView: UIScrollView) {
        var offsetY = scrollView.contentOffset.y + scrollView.contentInset.top
        
        if offsetY >= 0 {
            // 上拉，变更布局
            if offsetY >= botView.bounds.size.height {
                offsetY = botView.bounds.size.height
            }
     
            self.snp_updateConstraints { (make) in
                make.height.equalTo(scrollView.contentInset.top - offsetY)
            }
            self.layoutIfNeeded() // 必须确定父控件约束，才可变更子控件约束，否则crash
            
            var space = (offsetY / botView.bounds.size.height * 80 * 2.5)
            if space > 80.0 { space = 80.0 }
            searchTextF.snp_updateConstraints { (make) in
                make.trailing.equalToSuperview().inset(10 + space)
            }
            
            leftIcon.alpha = 1 - offsetY / botView.bounds.size.height
            self.alpha = 1
            self.transform = .identity
        } else {
            // 下拉，还原布局
            self.snp_updateConstraints { (make) in
                make.height.equalTo(scrollView.contentInset.top)
            }
            self.layoutIfNeeded() // 必须确定父控件约束，才可变更子控件约束，否则crash
            
            searchTextF.snp_updateConstraints { (make) in
                make.trailing.equalToSuperview().inset(10)
            }
            
            leftIcon.alpha = 1
            self.alpha = 1 + offsetY / botView.bounds.size.height
            self.transform = CGAffineTransform(translationX: 0, y: -offsetY)
        }
    }
}
