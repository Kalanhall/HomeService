//
//  TableViewControl.swift
//  HomeService
//
//  Created by Logic on 2020/3/30.
//

import UIKit
import RefreshKit
import CustomLoading

class HomeTableViewControl: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // 关联视图
    var navigationBarControl: NavigationBarControl?
    var headerRefresh: DefaultRefreshHeader!
    var animatRefresh: JDPullRefreshHeader!
    var isPushAdvert = false
    typealias VoidBlock = () -> Void
    var didEndDraggingCallBack: VoidBlock?
    
    // MARK: - Lazy Load
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
        }
        return tableView
    } ()
    
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
        navigationBarControl?.navigationBar.alphaEnable = navigationBarControl?.advertView.image != nil
        navigationBarControl?.navigationBar.scrollDidScroll(scrollView)

        // 导航栏下部背景图处理
        var offsetY = scrollView.contentOffset.y + (navigationBarControl?.navigationBar.originalInsert ?? 0)
        if offsetY > 0 {
            navigationBarControl?.navigationFooter.transform = CGAffineTransform(translationX: 0, y: -offsetY) // 导航栏下移
        } else {
            navigationBarControl?.navigationFooter.transform = .identity
        }
        navigationBarControl?.navigationFooter.alpha = navigationBarControl?.navigationBar.alpha ?? 0

        // 下拉广告图处理，> 刷新控件高度 才移动广告视图
        if isPushAdvert == false && navigationBarControl?.advertView.image != nil {
            if offsetY < 0 && fabs(offsetY) >= headerRefresh.bounds.size.height {
                if scrollView.isDragging {
                    if fabs(offsetY) >= headerRefresh.bounds.size.height * 3 {
                        headerRefresh.textLabel.text = "松开得惊喜"
                    } else {
                        headerRefresh.textLabel.text = "继续下拉有惊喜"
                    }
                }
                navigationBarControl?.advertView.transform = CGAffineTransform(translationX: 0, y: fabs(offsetY) - headerRefresh.bounds.size.height)
            } else {
                navigationBarControl?.advertView.transform = .identity
            }
            navigationBarControl?.advertView.alpha = 1 - (navigationBarControl?.navigationBar.alpha ?? 0)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if navigationBarControl?.advertView.image != nil {
            var offsetY = scrollView.contentOffset.y + (navigationBarControl?.navigationBar.originalInsert ?? 0)
            if  offsetY < 0 && fabs(offsetY) >= headerRefresh.bounds.size.height * 3 {
                self.isPushAdvert = true
                UIView.animate(withDuration: 0.3, animations: {
                    self.navigationBarControl?.advertView.transform = CGAffineTransform(translationX: 0, y: self.EXScreenHeight() - (self.navigationBarControl?.navigationBar.bounds.size.height ?? 0) - 100.auto())
                    self.tableView.transform = CGAffineTransform(translationX: 0, y: self.tableView.bounds.size.height)
                }) { (finish) in
                    if self.didEndDraggingCallBack != nil {
                        self.didEndDraggingCallBack!()
                    }
                }
            }
        }
    }
    
    func createRefresh(with type: Int) {
        // 根据广告标识，处理相关UI布局
        if type == 0 {
            animatRefresh = JDPullRefreshHeader(frame: CGRect(x: 0,y: 0,width: tableView.bounds.width,height: 60))
            tableView.handleRefreshHeader(with: animatRefresh,container:self) { [weak self] in
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
            headerRefresh.setText("下拉刷新", mode: .pullToRefresh)
            headerRefresh.setText("更新中", mode: .refreshing)
            tableView.handleRefreshHeader(with: headerRefresh, container: self) { [weak self] in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    if self?.isPushAdvert == false {
                        self?.tableView.switchRefreshHeader(to: .normal(.none, 0))
                    }
                }
            }
            
            headerRefresh.setText("继续下拉有惊喜", mode: .releaseToRefresh)
        }
    }
}
