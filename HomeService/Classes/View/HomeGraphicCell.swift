//
//  HomeGraphicCell.swift
//  HomeService
//
//  Created by Kalan on 2020/8/25.
//

import UIKit
import AsyncDisplayKit
import Extensions

class HomeGraphicCell: ASCellNode {
    
    let iconNode = ASNetworkImageNode()
    let nameNode = ASTextNode()
    let timeNode = ASTextNode()
    let lineNode = ASTextNode()
    
    override init() {
        super.init()
        
        iconNode.style.preferredSize = CGSize(width: 50.auto(), height: 50.auto())
        iconNode.image = UIImage.image(named: "logo", in: Bundle(for: HomeGraphicCell.self))
        addSubnode(iconNode)
        
        nameNode.attributedText = NSAttributedString(string: "一刀一个小朋友",
                                                     attributes: [.font : UIFont.systemFont(ofSize: 15),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x666666)])
        addSubnode(nameNode)
        
        
        timeNode.attributedText = NSAttributedString(string: "2020-08-26 17:39:02",
                                                     attributes: [.font : UIFont.systemFont(ofSize: 12),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0xE5E5E5)])
        addSubnode(timeNode)
        
//        lineNode.backgroundColor = UIColor.color(hexNumber: 0xE3E3E3)
//        addSubnode(lineNode)
        
        let backView = UIView()
        backView.backgroundColor = UIColor.color(hexNumber: 0xF9F9F9)
        selectedBackgroundView = backView
    }

    // ASLayoutSpec
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // 局部
        let name = ASStackLayoutSpec.vertical()
        name.style.flexShrink = 1
        name.style.flexGrow = 1
        name.spacing = 10
        name.children = [nameNode, timeNode]
        // 整体
        let conten = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 10,
                                       justifyContent: .start,
                                       alignItems: .start,
                                       children: [iconNode, name])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: conten)
    }
}
