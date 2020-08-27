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
        
        imageNode.image = UIImage.image(named: "logo", in: Bundle(for: HomeGraphicCell.self))
        layer.borderWidth = 1
        addSubnode(imageNode)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: imageNode)
    }
}
