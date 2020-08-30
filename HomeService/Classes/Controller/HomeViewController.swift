//
//  HomeViewController.swift
//  Alamofire
//
//  Created by Kalan on 2020/8/6.
//

import UIKit
import SnapKit
import HBDNavigationBar
import JXSegmentedView

class HomeViewController: UIViewController, JXSegmentedViewDelegate, JXSegmentedListContainerViewDataSource {
    
    let segmentedView = JXSegmentedView()
    var segmentedDataSource: JXSegmentedBaseDataSource?
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hbd_barShadowHidden = true

        view.addSubview(listContainerView)
        listContainerView.snp_makeConstraints { (make) in
            make.leading.bottom.trailing.equalTo(0)
            make.top.equalTo(0)
        }
        segmentedView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44)
        
        let titles = ["最新", "热门", "打听", "吐槽", "公告"]
        // 配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.indicatorHeight = 2
        indicator.indicatorCornerRadius = 1
        indicator.verticalOffset = 5
        indicator.lineStyle = .lengthenOffset
        indicator.indicatorColor = UIColor.color(hexNumber: 0xFF2618)
        segmentedView.indicators = [indicator]
        // 配置数据源
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.titles = titles
        dataSource.itemSpacing = 20
        dataSource.titleNormalFont = UIFont.boldSystemFont(ofSize: 16)
        dataSource.isTitleColorGradientEnabled = true
        dataSource.isItemSpacingAverageEnabled = false
        dataSource.isTitleZoomEnabled = true
        dataSource.titleSelectedZoomScale = 1.2
        dataSource.titleSelectedColor = UIColor.color(hexNumber: 0xFF2618)
        segmentedDataSource = dataSource
        
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        segmentedView.listContainer = listContainerView
        navigationItem.titleView = segmentedView
        
    }
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return HomeGraphicController.controller(index: index)
    }
}


