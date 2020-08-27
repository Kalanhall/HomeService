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
    let textNode = ASTextNode()
    var imagesNode: ASCollectionNode!
    let timeNode = ASTextNode()
    let editNode = ASButtonNode()
    let lineNode = ASTextNode()
    var imagesCount: Int = 0
    
    init(numberOfImages: Int) {
        super.init()
        
        selectionStyle = .none
        imagesCount = numberOfImages
        
        iconNode.style.preferredSize = CGSize(width: 40.auto(), height: 40.auto())
        iconNode.cornerRadius = 4
        iconNode.clipsToBounds = true
        iconNode.backgroundColor = UIColor.color(hexNumber: 0xF9F9F9)
        iconNode.setURL(URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598532482335&di=0d5afbdafe006a8c3d42191794afd8b9&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D0241830ebe014a90813e46b599763971%2F6d2aaa4bd11373f09e545323a30f4bfbfaed048f.jpg"), resetToDefault: true)
        addSubnode(iconNode)
        
        nameNode.style.spacingBefore = 5
        nameNode.attributedText = NSAttributedString(string: "微信朋友圈",
                                                     attributes: [.font : UIFont.boldSystemFont(ofSize: 15),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x33328B)])
        addSubnode(nameNode)
        
        textNode.style.spacingBefore = -5
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
        
        timeNode.attributedText = NSAttributedString(string: "1小时前",
                                                     attributes: [.font : UIFont.systemFont(ofSize: 13),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x777777)])
        addSubnode(timeNode)
        
        editNode.cornerRadius = 5
        editNode.clipsToBounds = true
        editNode.style.preferredSize = CGSize(width: 30, height: 20)
        editNode.setImage(UIImage.image(named: "more", in: Bundle(for: HomeGraphicCell.self)), for: .normal)
        editNode.setBackgroundImage(UIImage.image(color: UIColor.color(hexNumber: 0xF5F5F5)), for: .normal)
        editNode.setBackgroundImage(UIImage.image(color: UIColor.color(hexNumber: 0xE5E5E5)), for: .highlighted)
        addSubnode(editNode)
        
        lineNode.backgroundColor = UIColor.color(hexNumber: 0xE3E3E3)
        lineNode.style.flexGrow = 1
        lineNode.style.preferredSize = CGSize(width: 0, height: 0.5)
        addSubnode(lineNode)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return imagesCount
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let cell = HomeGraphicImageCell()
        
        return cell
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        print("点击图片 \(indexPath)")
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
        var width = Double(UIScreen.main.bounds.size.width - 60/*左间距*/ - 30/*右间距*/)
        let itemWidth = (width - 5*2/*内边距*/) / 3
        var height = 0.0
        switch imagesCount {
        case 0:
            imagesNode.style.spacingBefore = -10
        case 1:
            height = Double(arc4random_uniform(50) + 160)
            width = Double(arc4random_uniform(50) + 120)
        case 4:
            height = itemWidth * 2 + 5/*内边距*/
            width = height
        default:
            let row = imagesCount/3 + (imagesCount % 3 > 0 ? 1 : 0)
            height = itemWidth * Double(row) + Double((row - 1) * 5/*内边距*/)
        }
        imagesNode.style.preferredSize = CGSize(width: width, height: height)
        
        let bottom = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 10,
                                       justifyContent: .spaceBetween,
                                       alignItems: .center,
                                       children: [timeNode, editNode])
        
        // 内容 - 文字 / 图片容器 / 时间 / 评论按钮
        let content = ASStackLayoutSpec.vertical()
        content.style.flexShrink = 1
        content.style.flexGrow = 1
        content.spacing = 10
        content.children = [nameNode, textNode, imagesNode, bottom]

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
