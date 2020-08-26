//
//  HomeGraphicController.swift
//  HomeService
//
//  Created by Kalan on 2020/8/25.
//

import UIKit
import AsyncDisplayKit
import SnapKit

class HomeGraphicController: JXSegmentController, ASTableDelegate, ASTableDataSource {
    
    var controllerIndex = 0
    lazy var tableNode: ASTableNode = {
        var tableNode = ASTableNode()
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.separatorStyle = .none
        tableNode.view.showsVerticalScrollIndicator = false
        return tableNode
    }()
    
    class func controller(index: Int) -> HomeGraphicController {
        let vc = HomeGraphicController()
        vc.controllerIndex = index;
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubnode(tableNode)
        tableNode.view.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        print("页面下标：\(controllerIndex)")
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let cell = HomeGraphicCell()
        
        return cell
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
        
    }
}
