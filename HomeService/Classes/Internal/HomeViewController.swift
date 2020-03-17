//
//  HomeViewController.swift
//  HomeService
//
//  Created by Logic on 2020/3/13.
//  首页

import UIKit
import SnapKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var navigationBar = { () -> HomeNavigationBar in
        let view = HomeNavigationBar()
        view.topView.image = UIImage.image(named: "navtop", in: Bundle(for: type(of: self)))
        view.botView.image = UIImage.image(named: "navbot", in: Bundle(for: type(of: self)))
        return view
    } ()
    
    lazy var navigationFootter = { () -> UIImageView in
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.image = UIImage.image(named: "navfootter", in: Bundle(for: type(of: self)))
        return view
    } ()
    
    lazy var advertView = { () -> UIImageView in
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage.image(named: "advertView", in: Bundle(for: type(of: self)))
        view.alpha = 0
        return view
    } ()
    
    lazy var tableView = { () -> UITableView in
        let tableView = UITableView(frame: .zero, style: UITableView.Style.plain)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        return tableView
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        kl_barAlpha = 0
        kl_barStyle = .blackOpaque
        
//        https://m.360buyimg.com/mobilecms/jfs/t1/85429/28/14743/48503/5e69e4b9Eeb1dd33e/d00fd078bbc1a3ab.gif
        
        let barH = EXTopBarHeight() + 41.0
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(navigationBar)
        navigationBar.snp_makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(barH)
        }
        
        view.insertSubview(advertView, belowSubview: tableView)
        advertView.snp_makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(navigationBar.snp_bottom).inset(-100.auto())
        }
        
        view.insertSubview(navigationFootter, belowSubview: tableView)
        navigationFootter.snp_makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(navigationBar.snp_bottom)
        }
        
        tableView.contentInset = UIEdgeInsets(top: barH, left: 0, bottom: EXBottomBarHeight(), right: 0)
        tableView.setContentOffset(CGPoint(x: 0, y: -barH), animated: false)
        
        // 动图加载
        self.navigationBar.loadLeftIconImageWithURLString("https://m.360buyimg.com/mobilecms/jfs/t1/85429/28/14743/48503/5e69e4b9Eeb1dd33e/d00fd078bbc1a3ab.gif")
    }
    
    @objc func push() {
        let vc = HomeSpecialController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description()) as! UITableViewCell
        cell.backgroundColor = .clear
        cell.textLabel!.text = "\(indexPath)"
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 自定义导航栏处理
        navigationBar.scrollDidScroll(scrollView)
        
        // 导航栏下部背景图处理
        var offsetY = scrollView.contentOffset.y + scrollView.contentInset.top
        if offsetY > 0 {
            navigationFootter.transform = CGAffineTransform(translationX: 0, y: -offsetY) // 导航栏下移
        } else {
            navigationFootter.transform = .identity
        }
        
        // 下拉广告图处理，> 50 才移动广告视图
        advertView.alpha = 1 - navigationBar.alpha
        if offsetY < 0 && fabs(offsetY) >= 50.0 {
            advertView.transform = CGAffineTransform(translationX: 0, y: fabs(offsetY) - 50.0)
        } else {
            advertView.transform = .identity
        }
    }
}
