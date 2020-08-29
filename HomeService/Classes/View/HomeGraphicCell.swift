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

    override init() {
        super.init()

        selectionStyle = .none
        
        iconNode.style.preferredSize = CGSize(width: 40.auto(), height: 40.auto())
        iconNode.cornerRadius = 4
        iconNode.clipsToBounds = true
        iconNode.backgroundColor = UIColor.color(hexNumber: 0xF9F9F9)
        addSubnode(iconNode)

        addSubnode(nameNode)
        addSubnode(textNode)

        let delegate = ASCollectionGalleryLayoutDelegate(scrollableDirections: ASScrollDirectionVerticalDirections)
        imagesNode = ASCollectionNode(layoutDelegate: delegate, layoutFacilitator: nil)
        imagesNode.showsVerticalScrollIndicator = false
        imagesNode.delegate = self
        imagesNode.dataSource = self
        addSubnode(imagesNode)

        addSubnode(timeNode)

        editNode.cornerRadius = 5
        editNode.clipsToBounds = true
        editNode.setImage(UIImage.image(named: "more", in: Bundle(for: HomeGraphicCell.self)), for: .normal)
        addSubnode(editNode)

        lineNode.backgroundColor = UIColor.color(hexNumber: 0xE3E3E3)
        lineNode.style.maxHeight = ASDimension(unit:.points, value: 0.5)
        addSubnode(lineNode)
        
        timeNode.attributedText = NSAttributedString(string: "1小时前",
                                                     attributes: [.font : UIFont.systemFont(ofSize: 13),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x777777)])
        iconNode.setURL(URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598532482335&di=0d5afbdafe006a8c3d42191794afd8b9&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D0241830ebe014a90813e46b599763971%2F6d2aaa4bd11373f09e545323a30f4bfbfaed048f.jpg"), resetToDefault: true)
        nameNode.attributedText = NSAttributedString(string: "微信朋友圈",
                                                     attributes: [.font : UIFont.boldSystemFont(ofSize: 16),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x576B95)])
        textNode.attributedText = NSAttributedString(string: "时间会说明一切时间会说明时间会说明一切时间会说明时间会说明一切时间会说明时间会说明一切时间会说明",
                                                    attributes: [.font : UIFont.systemFont(ofSize: 14),
                                                                 .foregroundColor : UIColor.color(hexNumber: 0x000000)])
        imagesCount = Int(arc4random_uniform(10))
        
    }
    
    override func didLoad() {
        super.didLoad()

        // 这玩意必须在主线程
        let delegate = imagesNode.layoutDelegate as! ASCollectionGalleryLayoutDelegate
        delegate.propertiesProvider = self
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return imagesCount
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let cell = HomeGraphicImageCell()
        cell.imageNode.setURL(URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598532482335&di=0d5afbdafe006a8c3d42191794afd8b9&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D0241830ebe014a90813e46b599763971%2F6d2aaa4bd11373f09e545323a30f4bfbfaed048f.jpg"), resetToDefault: true)
        
        return cell
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        print("点击图片 \(indexPath)")
    }
    
    func galleryLayoutDelegate(_ delegate: ASCollectionGalleryLayoutDelegate, sizeForElements elements: ASElementMap) -> CGSize {
        switch imagesCount {
        case 1:
            return CGSize(width: imagesNode.frame.size.height * (120 / 160)/*图片宽高比*/, height: imagesNode.frame.size.height)
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
        if imagesCount > 0 {
            var width = Double(UIScreen.main.bounds.size.width - 60 * 2/*左间距+右间距*/)
            let itemWidth = (width - 5*2/*内边距*/) / 3
            var height = 0.0
            let row = imagesCount/3 + (imagesCount % 3 > 0 ? 1 : 0)
            height = itemWidth * Double(row) + Double((row - 1) * 5/*内边距*/)
            let imageH = width / (120 / 160)
            if imagesCount == 1 {
                height = imageH < width ? imageH : width
            } else if imagesCount == 4 {
                width = height
            }
            imagesNode.style.preferredSize = CGSize(width: width, height: height)
            editNode.style.preferredSize = CGSize(width: 44, height: 28)
        }
        
        let bottomLayout = ASStackLayoutSpec.horizontal()
        bottomLayout.justifyContent = .spaceBetween
        bottomLayout.alignItems = .center
        bottomLayout.style.alignSelf = .stretch // 嵌套太多，需要覆盖布局
        bottomLayout.children = [timeNode, editNode]
        
        let rightLayout = ASStackLayoutSpec.vertical()
        rightLayout.justifyContent = .start
        rightLayout.alignItems = .start
        rightLayout.style.flexShrink = 1
        rightLayout.style.flexGrow = 1
        
        if imagesCount > 0 && textNode.attributedText != nil {
            rightLayout.children = [nameNode, textNode, imagesNode, bottomLayout]
        } else if imagesCount > 0  {
            rightLayout.children = [nameNode, imagesNode, bottomLayout]
        } else if textNode.attributedText != nil {
            rightLayout.children = [nameNode, textNode, bottomLayout]
        }
        
        let topLayout = ASStackLayoutSpec.horizontal()
        topLayout.spacing = 10
        topLayout.justifyContent = .start
        topLayout.alignItems = .start
        topLayout.children = [iconNode, rightLayout]
        
        let contentLayout = ASStackLayoutSpec.vertical()
        contentLayout.justifyContent = .start
        contentLayout.alignItems = .stretch
        contentLayout.children = [ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10), child: topLayout), lineNode]
        
        nameNode.style.spacingBefore = 5
        textNode.style.spacingBefore = 5
        imagesNode.style.spacingBefore = 10
        bottomLayout.style.spacingBefore = 7
        
        return contentLayout
    }
}
