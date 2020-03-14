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
        let bar = HomeNavigationBar()
        bar.backgroundColor = .red
        return bar
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
        return tableView
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        kl_barAlpha = 0
        kl_barStyle = .blackOpaque
        
//        https://m.360buyimg.com/mobilecms/jfs/t1/85429/28/14743/48503/5e69e4b9Eeb1dd33e/d00fd078bbc1a3ab.gif
        
        view.addSubview(navigationBar)
        navigationBar.snp_makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(navigationBar.snp_bottom)
        }
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
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offsetY = scrollView.contentOffset.y

    }
}
