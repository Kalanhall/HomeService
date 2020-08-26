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
    let textNode = ASTextNode()
    var imagesNode: ASCollectionNode!
    let lineNode = ASTextNode()
    
    override init() {
        super.init()
        
        iconNode.style.preferredSize = CGSize(width: 40.auto(), height: 40.auto())
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
        
        textNode.maximumNumberOfLines = 5
        textNode.attributedText = NSAttributedString(string: "时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切",
                                                     attributes: [.font : UIFont.systemFont(ofSize: 13),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x222222)])
        addSubnode(textNode)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        imagesNode = ASCollectionNode(collectionViewLayout: layout)
        imagesNode.style.preferredSize = CGSize(width: 0, height: 150.auto())
        addSubnode(imagesNode)
        
        lineNode.backgroundColor = UIColor.color(hexNumber: 0xE3E3E3)
        lineNode.style.flexGrow = 1
        lineNode.style.preferredSize = CGSize(width: 0, height: 0.5)
        addSubnode(lineNode)
        
        let backView = UIView()
        backView.backgroundColor = UIColor.color(hexNumber: 0xF9F9F9)
        selectedBackgroundView = backView
    }

    // ASLayoutSpec
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        // 头部 - 文字
        let name = ASStackLayoutSpec.vertical()
        name.style.flexShrink = 1
        name.style.flexGrow = 1
        name.spacing = 10
        name.children = [nameNode, timeNode]
        
        // 头部
        let header = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 10,
                                       justifyContent: .start,
                                       alignItems: .center,
                                       children: [iconNode, name])
        
        // 整体
        let conten = ASStackLayoutSpec.vertical()
        conten.style.flexShrink = 1
        conten.style.flexGrow = 1
        conten.spacing = 10
        conten.children = [header, textNode, imagesNode, lineNode]
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10), child: conten)
    }
}
