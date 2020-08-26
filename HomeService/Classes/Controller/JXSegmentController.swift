//
//  JXSegmentController.swift
//  HomeService
//
//  Created by Kalan on 2020/8/25.
//

import UIKit
import JXSegmentedView

class JXSegmentController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}

extension JXSegmentController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
