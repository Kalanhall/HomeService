//
//  HomeGraphicCell.swift
//  HomeService
//
//  Created by Kalan on 2020/8/25.
//

import UIKit
import AsyncDisplayKit
import Extensions

class HomeGraphicCell: ASCellNode, ASCollectionDelegate, ASCollectionDataSource, ASCollectionGalleryLayoutPropertiesProviding {

    let iconNode = ASNetworkImageNode()
    let nameNode = ASTextNode()
    let timeNode = ASTextNode()
    let textNode = ASTextNode()
    var imagesNode: ASCollectionNode!
    let lineNode = ASTextNode()
    var imagesCount: Int = 0
    
    init(numberOfImages: Int) {
        super.init()
        
        imagesCount = numberOfImages
        
        iconNode.style.preferredSize = CGSize(width: 40.auto(), height: 40.auto())
        iconNode.image = UIImage.image(named: "logo", in: Bundle(for: HomeGraphicCell.self))
        addSubnode(iconNode)
        
        nameNode.attributedText = NSAttributedString(string: "一刀一个小朋友",
                                                     attributes: [.font : UIFont.systemFont(ofSize: 15),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0xFF7D25)])
        addSubnode(nameNode)
        
        
        timeNode.style.flexGrow = 0
        timeNode.attributedText = NSAttributedString(string: "1小时前",
                                                     attributes: [.font : UIFont.systemFont(ofSize: 12),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x777777)])
        addSubnode(timeNode)
        
        textNode.maximumNumberOfLines = 5
        textNode.attributedText = NSAttributedString(string: "时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切时间会说明一切",
                                                     attributes: [.font : UIFont.systemFont(ofSize: 13),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x222222)])
        
        addSubnode(textNode)
        
        let delegate = ASCollectionGalleryLayoutDelegate(scrollableDirections: .down)
        delegate.propertiesProvider = self
        imagesNode = ASCollectionNode(layoutDelegate: delegate, layoutFacilitator: nil)
        imagesNode.showsVerticalScrollIndicator = false
        imagesNode.delegate = self
        imagesNode.dataSource = self
        addSubnode(imagesNode)
        
        lineNode.backgroundColor = UIColor.color(hexNumber: 0xE3E3E3)
        lineNode.style.flexGrow = 1
        lineNode.style.preferredSize = CGSize(width: 0, height: 0.5)
        addSubnode(lineNode)
        
        let backView = UIView()
        backView.backgroundColor = UIColor.color(hexNumber: 0xF9F9F9)
        selectedBackgroundView = backView
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return imagesCount
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let cell = HomeGraphicImageCell()
        
        return cell
    }
    
    func galleryLayoutDelegate(_ delegate: ASCollectionGalleryLayoutDelegate, sizeForElements elements: ASElementMap) -> CGSize {
        switch imagesCount {
        case 1:
            return imagesNode.frame.size
        default:
            let size = (Int(imagesNode.frame.size.width) - (imagesCount == 4 ? 1 : 2) * 5/*内边距*/) / (imagesCount == 4 ? 2 : 3)
            return CGSize(width: size, height: size)
        }
    }
    
    func galleryLayoutDelegate(_ delegate: ASCollectionGalleryLayoutDelegate, minimumLineSpacingForElements elements: ASElementMap) -> CGFloat {
        return 5
    }
    
    func galleryLayoutDelegate(_ delegate: ASCollectionGalleryLayoutDelegate, minimumInteritemSpacingForElements elements: ASElementMap) -> CGFloat {
        return 5
    }

    // ASLayoutSpec
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        // 内容 - 图片(图片个数对应的算法)
        var width = 0.0
        var height = 0.0
        switch imagesCount {
        case 0:
            imagesNode.style.spacingBefore = -10
        case 1:
            height = Double(arc4random_uniform(50) + 160)
            width = Double(arc4random_uniform(50) + 120)
        case 4:
            height = Double(UIScreen.main.bounds.size.width - 70/*左右间距和*/ - 5*2/*内边距*/) / 3 * 2 + 5/*内边距*/
            width = height
        default:
            let row = imagesCount/3 + (imagesCount % 3 > 0 ? 1 : 0)
            height = Double(UIScreen.main.bounds.size.width - 70/*左右间距和*/ - 5*2/*内边距*/) / 3 * Double(row) + Double((row - 1) * 5/*内边距*/)
        }
        imagesNode.style.preferredSize = CGSize(width: width, height: height)
        
        // 内容 - 文字 + 图片容器
        let content = ASStackLayoutSpec.vertical()
        content.style.flexShrink = 1
        content.style.flexGrow = 1
        content.spacing = 10
        content.children = [nameNode, textNode, imagesNode, timeNode]

        // 切割头像（左侧）/ 内容（右侧）
        let body = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 10,
                                       justifyContent: .start,
                                       alignItems: .start,
                                       children: [iconNode, content])
        
        
        let vertical = ASStackLayoutSpec.vertical()
        vertical.style.flexShrink = 1
        vertical.style.flexGrow = 1
        vertical.spacing = 10
        vertical.children = [ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10), child: body), lineNode]
        return vertical
    }
}
