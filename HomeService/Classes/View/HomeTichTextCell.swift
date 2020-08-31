//
//  HomeTichTextCell.swift
//  HomeService
//
//  Created by Kalan on 2020/8/31.
//

import UIKit
import AsyncDisplayKit

class HomeTichTextCell: ASCellNode {
    let textNode = ASTextNode()
    
    init(text: String) {
        super.init()
        selectionStyle = .none
        
        textNode.backgroundColor = UIColor.color(hexNumber: 0xF7F7F7)
        textNode.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        textNode.cornerRadius = 4
        textNode.clipsToBounds = true
        addSubnode(textNode)
        
        bindingData(string: text)
    }
    
    func bindingData(string: String) {
        let para = NSMutableParagraphStyle()
        para.lineSpacing = 2
        textNode.attributedText = NSAttributedString(string: string,
                                                     attributes: [.font : UIFont.boldSystemFont(ofSize: 14),
                                                                  .paragraphStyle : para,
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x576B95)])
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let lastIndex = 1
        if indexPath?.row == 1 { // 第一条
            textNode.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        if indexPath?.row == lastIndex { // 最后一条
            textNode.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 42.auto()+20, bottom: 0, right: 5), child: textNode)
    }
}
