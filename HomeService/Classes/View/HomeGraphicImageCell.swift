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
        imageNode.setURL(URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598532482335&di=0d5afbdafe006a8c3d42191794afd8b9&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D0241830ebe014a90813e46b599763971%2F6d2aaa4bd11373f09e545323a30f4bfbfaed048f.jpg"), resetToDefault: true)
        
        
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: imageNode)
    }
}
