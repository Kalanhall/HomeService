//
//  HomeGraphicImageCell.swift
//  Alamofire
//
//  Created by Kalan on 2020/8/26.
//

import UIKit
import AsyncDisplayKit
import Extensions

class HomeGraphicImageCell: ASCellNode {
    
    let imageNode = ASNetworkImageNode()
    
    override init() {
        super.init()
        
        imageNode.backgroundColor = UIColor.color(hexNumber: 0xF9F9F9)
        imageNode.contentMode = .scaleAspectFill
        addSubnode(imageNode)
        
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: imageNode)
    }
}
