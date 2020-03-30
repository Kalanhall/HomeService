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

class HomeSpecialController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var topView = { () -> UIImageView in
        let topView = UIImageView()
        topView.image = UIImage.image(named: "top", in: Bundle(for: type(of: self)))
        return topView
    }()
    
    lazy var botView = { () -> UIImageView in
        let botView = UIImageView()
        botView.image = UIImage.image(named: "bot", in: Bundle(for: type(of: self)))
        return botView
    }()
    
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
        return tableView
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.color(hexNumber: 0xF5F5F5)
        navigationItem.titleView = UIImageView(image: UIImage.image(named: "title", in: Bundle(for: self.classForCoder)))
        
        kl_barAlpha = 0
        kl_tintColor = .white
        kl_barStyle = .blackOpaque
        
        view.addSubview(topView)
        topView.snp_makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(102.auto())
        }
        
        view.insertSubview(botView, belowSubview: topView)
        botView.snp_makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(topView.snp_bottom)
            make.height.equalTo(174.auto())
        }
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(topView.snp_bottom)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description()) as! UITableViewCell
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            // 下拉
            offsetY = 0
        }
        botView.transform = CGAffineTransform(translationX: 0, y: -offsetY)
    }
}
