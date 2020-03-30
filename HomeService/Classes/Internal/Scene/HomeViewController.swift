//
//  HomeViewController.swift
//  HomeService
//
//  Created by Logic on 2020/3/13.
//  首页

import UIKit
import SnapKit
import Extensions
import KLNavigationController
import LoginServiceInterface

class HomeViewController: UIViewController {

        
    // MARK: - Lazy Load
    lazy var navigationBarControl = { () -> NavigationBarControl in
        let control = NavigationBarControl()
        return control
    } ()
    
    lazy var tableViewControl = { [weak self] () -> HomeTableViewControl in
        let control = HomeTableViewControl()
        control.navigationBarControl = self?.navigationBarControl
        return control
    } ()

    // MARK: - Circle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
        actionInit()
        
        // 导航栏动图加载
        navigationBarControl.navigationBar.loadLeftIconImageWithURLString("https://m.360buyimg.com/mobilecms/jfs/t1/100993/22/16379/203958/5e7cb242Eecf6e7d3/f8dd649c0c215198.gif")
        
        // 导航栏背景图加载
        navigationBarControl.navigationBar.topView.kl_setImage(with: URL(string: "https://m.360buyimg.com/mobilecms/s1125x939_jfs/t1/108997/36/10225/123811/5e7aff96E3685704b/a4c90f5b8a0cb6e9.jpg.dpg.webp"), placeholder: nil, options: .progressiveBlur) { [weak self] (image, url, type, stage, error) in
            let size = CGSize(width: (image?.size.width ?? 0) * UIScreen.main.scale, height: (image?.size.height ?? 0) * UIScreen.main.scale)
  
            let fotheight = 173.auto() * (size.width / self!.navigationBarControl.navigationFooter.bounds.size.width)
            let fotrect = CGRect(x: 0, y: size.height - fotheight, width: size.width, height: fotheight)
            self!.navigationBarControl.navigationFooter.image = UIImage.imageCropping(image, in: fotrect, with: UIImage.image(named: "navfooter", in: Bundle(for: HomeViewController.self)))
            
            let botheight = self!.navigationBarControl.navigationBar.botView.bounds.size.height * (size.width / self!.navigationBarControl.navigationBar.botView.bounds.size.width)
            let botrect = CGRect(x: 0, y: size.height - botheight - fotheight, width: size.width, height: botheight)
            self!.navigationBarControl.navigationBar.botView.image = UIImage.imageCropping(image, in: botrect, with: UIImage.image(named: "navbot", in: Bundle(for: HomeViewController.self)))
            
            let topheight = self!.navigationBarControl.navigationBar.topView.bounds.size.height * (size.width / self!.navigationBarControl.navigationBar.topView.bounds.size.width)
            let toprect = CGRect(x: 0, y: size.height - botheight - fotheight - topheight, width: size.width, height: topheight)
            self!.navigationBarControl.navigationBar.topView.image = UIImage.imageCropping(image, in: toprect, with: UIImage.image(named: "navtop", in: Bundle(for: HomeViewController.self)))
        }

        // 广告图加载
        navigationBarControl.advertView.kl_setImage(with: URL(string: "https://m.360buyimg.com/mobilecms/jfs/t1/88845/33/15729/179591/5e74c7a5Eabde88f3/8f5de4d867ad7b57.png"), placeholder: UIImage.image(named: "advertView", in: Bundle(for: type(of: self))), options: .progressiveBlur) { [weak self] (image, url, type, stage, error) in
            self?.tableViewControl.createRefresh(with: image == nil ? 0 : 1)
        }
    }
    
    // MARK: - Private
    func viewInit() {
        kl_barAlpha = 0
        kl_barStyle = .blackOpaque
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
        
        let barH = EXTopBarHeight() + 41.0
        
        view.addSubview(tableViewControl.tableView)
        tableViewControl.tableView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(navigationBarControl.navigationBar)
        navigationBarControl.navigationBar.snp_makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(barH)
        }
        
        view.insertSubview(navigationBarControl.advertView, belowSubview: tableViewControl.tableView)
        navigationBarControl.advertView.snp_makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(navigationBarControl.navigationBar.snp_bottom).inset(-100.auto())
        }
        
        view.insertSubview(navigationBarControl.navigationFooter, belowSubview: tableViewControl.tableView)
        navigationBarControl.navigationFooter.snp_makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(navigationBarControl.navigationBar.snp_bottom)
            make.height.lessThanOrEqualTo(173.auto())
        }
        
        tableViewControl.tableView.contentInset = UIEdgeInsets(top: barH, left: 0, bottom: EXBottomBarHeight(), right: 0)
        tableViewControl.tableView.setContentOffset(CGPoint(x: 0, y: -barH), animated: false)
    }
    
    func actionInit() {
        navigationBarControl.navigationBar.msg.addTarget(self, action: #selector(login), for: .touchUpInside)
        navigationBarControl.navigationBar.scan.addTarget(self, action: #selector(push), for: .touchUpInside)
        navigationBarControl.navigationBar.cameraItem.addTarget(self, action: #selector(push), for: .touchUpInside)
        
        navigationBarControl.navigationBar.logoCallBack = { [weak self] in
            self?.push()
        }
        
        navigationBarControl.navigationBar.searchFieldCallBack = { [weak self] in
            self?.push()
        }
        
        tableViewControl.didEndDraggingCallBack = { [weak self] in
            // 跳转广告页
            let vc = HomeAdvertController()
    
            // 广告页取消回调
            vc.cancleCallBack = { [weak self] (touch) in
                self?.tableViewControl.isPushAdvert = false
                UIView.animate(withDuration: touch == true ? 0 : 0.3, animations: {
                    self?.tableViewControl.tableView.transform = .identity
                    self?.navigationBarControl.advertView.transform = .identity
                }) { (finish) in
                    if touch {
                        self?.push()
                    }
                }
                self?.tableViewControl.tableView.switchRefreshHeader(to: .normal(.none, 0))
            }
    
            self?.navigationController?.pushViewController(vc, animated: false)
        }

    }
    
    @objc private func login() {
        let vc = KLServer.shared().login(with: nil)
        let nav = KLNavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
    @objc private func push() {
        let vc = HomeSpecialController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
