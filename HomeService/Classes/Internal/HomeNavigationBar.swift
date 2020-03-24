//
//  HomeNavigationBar.swift
//  HomeService
//
//  Created by Logic on 2020/3/14.
//

import UIKit
import SnapKit
import KLImageView

class HomeNavigationBar: UIView, UITextFieldDelegate {
    
    typealias searchBlock = () -> Void
    var searchFieldCallBack: searchBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    func viewInit() {
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
        
        topView.addSubview(leftIcon)
        leftIcon.snp_makeConstraints { (make) in
            make.leading.equalTo(10)
            make.centerY.equalTo(msg.snp_centerY)
        }
        
        self.addSubview(searchField)
        searchField.snp_makeConstraints { (make) in
            make.height.equalTo(30)
            make.leading.equalTo(10)
            make.bottom.equalTo(-11)
            make.trailing.equalToSuperview().inset(10)
        }
        
        searchField.leftView = searchIcon
        searchField.leftViewMode = .always
        
        searchField.rightView = cameraIcon
        searchField.rightViewMode = .always
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
            
            var rate = offsetY / botView.bounds.size.height
            var space = rate * 80 * 2.5
            var margin = rate * 4 * 2.5
            if space > 80.0 { space = 80.0 }
            if margin > 4.0 { margin = 4.0 }
            searchField.snp_updateConstraints { (make) in
                make.trailing.equalToSuperview().inset(10 + space)
                make.bottom.equalTo(-11 + margin)
            }
            
            leftIcon.alpha = 1 - rate
            self.alpha = 1
//            self.transform = .identity
        } else {
            // 下拉，还原布局
            self.snp_updateConstraints { (make) in
                make.height.equalTo(scrollView.contentInset.top)
            }
            self.layoutIfNeeded() // 必须确定父控件约束，才可变更子控件约束，否则crash
            
            searchField.snp_updateConstraints { (make) in
                make.trailing.equalToSuperview().inset(10)
                make.bottom.equalTo(-11)
            }
            
            leftIcon.alpha = 1
            var rate = offsetY / 30.0
            self.alpha = 1 + rate
//            self.transform = CGAffineTransform(translationX: 0, y: -offsetY) // 导航栏下移
        }
    }
    
    /// 加载导航栏左侧图片，重新计算图片宽高
    func loadLeftIconImageWithURLString(_ url: String) {
        weak var wks = self
        leftIcon.kl_setImage(with: URL(string: url), placeholder: leftIcon.image, options: .progressiveBlur, completion: { (image, imageURL, type, stage, error) in
            if image != nil {
                var width = image!.size.width * (30.0 / image!.size.height)
                wks!.leftIcon.snp_remakeConstraints({ (make) in
                    make.left.equalTo(10)
                    make.height.equalTo(30)
                    make.centerY.equalTo(wks!.msg.snp_centerY)
                    make.width.equalTo(width)
                })
            }
        })
    }
    
    // MARK: - Delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (searchFieldCallBack != nil) {
            searchFieldCallBack!()
        }
        return false
    }
    
    // MARK: - Lazy Methods
    lazy var topView = { () -> KLImageView in
        let view = KLImageView()
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleToFill
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
    } ()
    
    lazy var botView = { () -> KLImageView in
        let view = KLImageView()
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleToFill
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
    } ()
    
    lazy var leftIcon = { () -> KLImageView in
        let view = KLImageView()
        view.image = UIImage.image(named: "navleft", in: Bundle(for: HomeNavigationBar.self))
        view.contentMode = .scaleAspectFit
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
    
    lazy var searchField = { () -> UITextField in
        let view = UITextField()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.delegate = self
        return view
    } ()
    
    var searchItem: UIButton!
    lazy var searchIcon = { () -> UIView in
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        self.searchItem = UIButton(type: .custom)
        self.searchItem.setImage(UIImage.image(named: "searchIcon", in: Bundle(for: HomeNavigationBar.self)), for: .normal)
        self.searchItem.frame = view.frame
        view.addSubview(self.searchItem!)
        return view
    } ()
    
    var cameraItem: UIButton!
    lazy var cameraIcon = { () -> UIView in
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        self.cameraItem = UIButton(type: .custom)
        self.cameraItem.setImage(UIImage.image(named: "cameraIcon", in: Bundle(for: HomeNavigationBar.self)), for: .normal)
        self.cameraItem.frame = view.frame
        view.addSubview(self.cameraItem!)
        return view
    } ()
}
