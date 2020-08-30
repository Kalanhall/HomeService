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

    lazy var iconNode: ASNetworkImageNode = {
        let icon = ASNetworkImageNode()
        icon.style.preferredSize = CGSize(width: 42.auto(), height: 42.auto())
        icon.cornerRadius = 4
        icon.clipsToBounds = true
        icon.backgroundColor = UIColor.color(hexNumber: 0xF9F9F9)
        return icon
    }()
    lazy var nameNode: ASTextNode = {
        return ASTextNode()
    }()
    lazy var textNode: ASTextNode = {
        return ASTextNode()
    }()
    lazy var imagesNode: ASCollectionNode = {
        let delegate = ASCollectionGalleryLayoutDelegate(scrollableDirections: ASScrollDirectionVerticalDirections)
        let imagesView = ASCollectionNode(layoutDelegate: delegate, layoutFacilitator: nil)
        imagesView.showsVerticalScrollIndicator = false
        imagesView.delegate = self
        imagesView.dataSource = self
        
        DispatchQueue.main.async {
            // 必须主线程设置
            delegate.propertiesProvider = self
        }
        
        return imagesView
    }()
    lazy var addressNode: ASButtonNode = {
        let address = ASButtonNode()
        address.style.spacingBefore = 5
        return address
    }()
    lazy var timeNode: ASTextNode = {
        return ASTextNode()
    }()
    lazy var editNode: ASButtonNode = {
        let edit = ASButtonNode()
        edit.cornerRadius = 5
        edit.clipsToBounds = true
        edit.setImage(UIImage.image(named: "more", in: Bundle(for: HomeGraphicCell.self)), for: .normal)
        edit.style.preferredSize = CGSize(width: 44, height: 28)
        return edit
    }()
    lazy var likeCommentNode: LikeCommentNode = {
        let likeComment = LikeCommentNode()
        likeComment.style.alignSelf = .stretch
        likeComment.cornerRadius = 4
        likeComment.clipsToBounds = true
        return likeComment
    }()
    lazy var lineNode: ASTextNode = {
        let line = ASTextNode()
        line.backgroundColor = UIColor.color(hexNumber: 0xE3E3E3)
        line.style.maxHeight = ASDimension(unit:.points, value: 0.5)
        return line
    }()
    var imagesCount: Int = 0

    override init() {
        super.init()

        selectionStyle = .none
        
        addSubnode(iconNode)
        addSubnode(nameNode)
        addSubnode(textNode)
        addSubnode(imagesNode)
        addSubnode(addressNode)
        addSubnode(timeNode)
        addSubnode(editNode)
        addSubnode(likeCommentNode)
        addSubnode(lineNode)
        
        bindingData()
    }
    
    func bindingData() {
        addressNode.setAttributedTitle(NSAttributedString(string: "深圳·宝安区",
                                                          attributes: [.font : UIFont.systemFont(ofSize: 12),
                                                                       .foregroundColor : UIColor.color(hexNumber: 0x576B95)]), for: .normal)
        timeNode.attributedText = NSAttributedString(string: "1小时前",
                                                     attributes: [.font : UIFont.systemFont(ofSize: 11),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x999999)])
        iconNode.setURL(URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598532482335&di=0d5afbdafe006a8c3d42191794afd8b9&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D0241830ebe014a90813e46b599763971%2F6d2aaa4bd11373f09e545323a30f4bfbfaed048f.jpg"), resetToDefault: true)
        nameNode.attributedText = NSAttributedString(string: "微信朋友圈",
                                                     attributes: [.font : UIFont.boldSystemFont(ofSize: 16),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x576B95)])
        
        imagesCount = Int(arc4random_uniform(10))
        let result = arc4random() % 2
        if result > 0 || imagesCount == 0 {
            textNode.attributedText = NSAttributedString(string: "时间会说明一切时间会说明时间会说明一切时间会说明时间会说明一切时间会说明时间会说明一切时间会说明",
                                                         attributes: [.font : UIFont.systemFont(ofSize: 14),
                                                                      .foregroundColor : UIColor.color(hexNumber: 0x000000)])
        }
        likeCommentNode.likeNode.attributedText = NSAttributedString(string: "ෆ 非死不可",
                                                     attributes: [.font : UIFont.boldSystemFont(ofSize: 14),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x576B95)])
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
            let size = (Int(imagesNode.frame.size.width) - (imagesCount == 4 ? 1 : 3) * 5/*内边距*/) / (imagesCount == 4 ? 2 : 3)
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
        
        var flexbox: [ASLayoutElement] = []
        // 添加昵称
        flexbox.append(nameNode)
        // 添加内容文本
        if textNode.attributedText != nil {
            flexbox.append(textNode)
        }
        // 添加内容图片
        if imagesCount > 0 {
            var width = Double(UIScreen.main.bounds.size.width - 62.auto() * 2/*左间距+右间距*/)
            let itemWidth = (width - 5*3/*内边距*/) / 3
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
            flexbox.append(imagesNode)
        }
        // 添加定位地址
        if addressNode.attributedTitle(for: .normal) != nil {
            flexbox.append(addressNode)
        }
        // 添加底部栏
        flexbox.append(bottomLayout)
        // 添加点赞行
        if likeCommentNode.likeNode.attributedText != nil {
            flexbox.append(likeCommentNode)
        }
        rightLayout.children = flexbox as! [ASLayoutElement]
        
        let topLayout = ASStackLayoutSpec.horizontal()
        topLayout.spacing = 10
        topLayout.justifyContent = .start
        topLayout.alignItems = .start
        topLayout.children = [
            iconNode,
            rightLayout
        ]
        
        let contentLayout = ASStackLayoutSpec.vertical()
        contentLayout.justifyContent = .start
        contentLayout.alignItems = .stretch
        contentLayout.children = [
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 7, right: 5), child: topLayout),
            lineNode
        ]
        
        nameNode.style.spacingBefore = 4
        textNode.style.spacingBefore = 6
        imagesNode.style.spacingBefore = 10
        bottomLayout.style.spacingBefore = 5
        
        return contentLayout
    }
}

class LikeCommentNode: ASDisplayNode {
    lazy var likeNode: ASTextNode = {
        let like = ASTextNode()
        like.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return like
    }()
    lazy var commentNode: ASTableNode = {
        let table = ASTableNode()
        table.style.alignSelf = .stretch
        table.backgroundColor = .clear
        table.style.minHeight = ASDimension(unit: .points, value: 40)
        table.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return table
    }()
    
    override init() {
        super.init()
        backgroundColor = UIColor.color(hexNumber: 0xF9F9F9)
        addSubnode(likeNode)
        addSubnode(commentNode)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayout = ASStackLayoutSpec.vertical()
        contentLayout.justifyContent = .start
        contentLayout.alignItems = .start
        contentLayout.style.flexShrink = 1
        contentLayout.style.flexGrow = 1
        contentLayout.children = [
            likeNode,
            commentNode
        ]
        return contentLayout
    }
}
