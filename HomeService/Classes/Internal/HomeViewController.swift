//
//  HomeViewController.swift
//  HomeService
//
//  Created by Logic on 2020/3/13.
//  首页

import UIKit
import SnapKit
import RefreshKit
import CustomLoading
import KLNavigationController
import LoginServiceInterface

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var headerRefresh: DefaultRefreshHeader!
    var animatRefresh: JDPullRefreshHeader!
    var isPushAdvert = false

    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
        actionInit()
        
        // 网络动图加载
        self.navigationBar.loadLeftIconImageWithURLString("https://m.360buyimg.com/mobilecms/jfs/t1/85429/28/14743/48503/5e69e4b9Eeb1dd33e/d00fd078bbc1a3ab.gif")
    }
    
    // MARK: - Private
    func viewInit() {
        kl_barAlpha = 0
        kl_barStyle = .blackOpaque
        view.backgroundColor = .white
        
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
        
        
        // 根据广告标识，处理相关UI布局
        if advertView.image == nil {
            animatRefresh = JDPullRefreshHeader(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width,height: 60))
                self.tableView.handleRefreshHeader(with: animatRefresh,container:self) { [weak self] in
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                        self?.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
                    }
            };
        } else {
            // 默认样式
            headerRefresh = DefaultRefreshHeader.header()
            headerRefresh.refreshHeight = 40
            headerRefresh.imageView.alpha = 0
            headerRefresh.indicator.alpha = 0
            headerRefresh.tintColor = .white
            headerRefresh.textLabel.font = UIFont.systemFont(ofSize: 12)
            headerRefresh.setText("更新中", mode: .refreshing)
            self.tableView.handleRefreshHeader(with: headerRefresh, container: self) { [weak self] in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    self?.tableView.switchRefreshHeader(to: .normal(.none, 0))
                }
            }
            
            headerRefresh.setText("继续下拉有惊喜", mode: .releaseToRefresh)
        }
    }
    
    func actionInit() {
        navigationBar.msg.addTarget(self, action: #selector(login), for: .touchUpInside)
        navigationBar.scan.addTarget(self, action: #selector(push), for: .touchUpInside)
        navigationBar.cameraItem.addTarget(self, action: #selector(push), for: .touchUpInside)
        
        navigationBar.logoCallBack = { [weak self] in
            self?.push()
        }
        
        navigationBar.searchFieldCallBack = { [weak self] in
            self?.push()
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

    // MARK: - Delegate
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
        navigationBar.alphaEnable = advertView.image != nil
        navigationBar.scrollDidScroll(scrollView)
        
        // 导航栏下部背景图处理
        var offsetY = scrollView.contentOffset.y + navigationBar.originalInsert
        if offsetY > 0 {
            navigationFootter.transform = CGAffineTransform(translationX: 0, y: -offsetY) // 导航栏下移
        } else {
            navigationFootter.transform = .identity
        }
        navigationFootter.alpha = navigationBar.alpha

        // 下拉广告图处理，> 刷新控件高度 才移动广告视图
        if self.isPushAdvert == false && advertView.image != nil {
            if offsetY < 0 && fabs(offsetY) >= headerRefresh.bounds.size.height {
                if scrollView.isDragging {
                    if fabs(offsetY) >= headerRefresh.bounds.size.height * 3 {
                        headerRefresh.textLabel.text = "松开得惊喜"
                    } else {
                        headerRefresh.textLabel.text = "继续下拉有惊喜"
                    }
                }
                advertView.transform = CGAffineTransform(translationX: 0, y: fabs(offsetY) - headerRefresh.bounds.size.height)
            } else {
                advertView.transform = .identity
            }
            advertView.alpha = 1 - navigationBar.alpha
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if advertView.image != nil {
            var offsetY = scrollView.contentOffset.y + navigationBar.originalInsert
            if  offsetY < 0 && fabs(offsetY) >= headerRefresh.bounds.size.height * 3 {
                self.isPushAdvert = true
                UIView.animate(withDuration: 0.3, animations: {
                    self.advertView.transform = CGAffineTransform(translationX: 0, y: self.EXScreenHeight() - self.navigationBar.bounds.size.height - 100.auto())
                    self.tableView.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.size.height)
                }) { (finish) in
                    self.tableView.switchRefreshHeader(to: .normal(.none, 0))
                    // 跳转广告页
                    let vc = HomeAdvertController()
                    self.navigationController?.pushViewController(vc, animated: false)
                    // 广告页取消回调
                    vc.cancleCallBack = { [weak self] (touch) in
                        self?.isPushAdvert = false
                        self?.navigationBar.alpha = 0
                        self?.navigationFootter.alpha = 0
                        UIView.animate(withDuration: touch == true ? 0 : 0.3, animations: {
                            self?.tableView.transform = .identity
                            self?.advertView.transform = .identity
                            self?.navigationBar.alpha = 1
                            self?.navigationFootter.alpha = 1
                        }) { (finish) in
                            if touch {
                                self?.push()
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Lazy Load
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
    
}
