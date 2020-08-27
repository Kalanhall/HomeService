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
        let cell = HomeGraphicCell(numberOfImages: Int(arc4random_uniform(10)))
        cell.editNode.addTarget(self, action: #selector(editTouchUpInside), forControlEvents: .touchUpInside)
        
        return cell
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: true)
        
    }
    
    @objc func editTouchUpInside(sender: ASButtonNode) {
        self.becomeFirstResponder()
//        sender.becomeFirstResponder()
        let menu = UIMenuController.shared
        menu.menuItems = [UIMenuItem(title: "点赞", action: #selector(dianzan)),
                          UIMenuItem(title: "评论", action: #selector(pinglun))]
        menu.setTargetRect(sender.frame, in: sender.view.superview!)
        menu.arrowDirection = .right
        menu.setMenuVisible(true, animated: true)
    }
    
    @objc func dianzan() {
        
    }
    
    @objc func pinglun() {
        
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if [#selector(dianzan), #selector(pinglun)].contains(action) {
            return true
        }
        return false
    }
}
