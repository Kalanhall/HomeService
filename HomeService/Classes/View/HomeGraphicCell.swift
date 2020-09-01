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
        imagesView.backgroundColor = .clear
        
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
    lazy var botlineNode: ASDisplayNode = {
        let lineNode = ASDisplayNode()
        lineNode.backgroundColor = UIColor.color(hexNumber: 0xE2E2E2)
        lineNode.style.minHeight = ASDimension(unit: .points, value: 0.5)
        return lineNode
    }()
    var currentModel: CommentModel!

    init(model: CommentModel) {
        super.init()
        
        currentModel = model
        selectionStyle = .none
        
        addSubnode(iconNode)
        addSubnode(nameNode)
        addSubnode(textNode)
        addSubnode(imagesNode)
        addSubnode(addressNode)
        addSubnode(timeNode)
        addSubnode(editNode)
        addSubnode(botlineNode)
        
        bindingData()
    }
    
    func bindingData() {
        iconNode.setURL(URL(string:currentModel?.iconURL ?? ""), resetToDefault: true)
        nameNode.attributedText = NSAttributedString(string: currentModel?.nickName ?? "",
                                                     attributes: [.font : UIFont.boldSystemFont(ofSize: 16),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x576B95)])
        textNode.attributedText = NSAttributedString(string: currentModel?.text ?? "",
                                                     attributes: [.font : UIFont.boldSystemFont(ofSize: 14),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x000000)])
        addressNode.setAttributedTitle(NSAttributedString(string: currentModel?.address ?? "",
                                                          attributes: [.font : UIFont.systemFont(ofSize: 12),
                                                                       .foregroundColor : UIColor.color(hexNumber: 0x576B95)]), for: .normal)
        
        timeNode.attributedText = NSAttributedString(string: currentModel?.time ?? "",
                                                     attributes: [.font : UIFont.systemFont(ofSize: 11),
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x999999)])
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return currentModel?.images?.count ?? 0
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let cell = HomeGraphicImageCell()
        let url = currentModel?.images?[indexPath.row] ?? ""
        cell.imageNode.setURL(URL(string: url), resetToDefault: true)
        
        return cell
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        print("点击图片 \(indexPath)")
    }
    
    func galleryLayoutDelegate(_ delegate: ASCollectionGalleryLayoutDelegate, sizeForElements elements: ASElementMap) -> CGSize {
        switch currentModel?.images?.count {
        case 1:
            return CGSize(width: imagesNode.frame.size.height * (120 / 160)/*图片宽高比*/, height: imagesNode.frame.size.height)
        default:
            let size = (Int(imagesNode.frame.size.width) - (currentModel?.images?.count == 4 ? 1 : 3) * 5/*内边距*/) / (currentModel?.images?.count == 4 ? 2 : 3)
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
        
        let blogLayout = ASStackLayoutSpec.vertical()
        blogLayout.justifyContent = .start
        blogLayout.alignItems = .start
        blogLayout.style.flexShrink = 1
        blogLayout.style.flexGrow = 1
        
        var flexbox: [ASLayoutElement] = []
        // 添加昵称
        flexbox.append(nameNode)
        // 添加内容文本
        if textNode.attributedText != nil {
            flexbox.append(textNode)
        }
        // 添加内容图片
        if currentModel?.images?.isEmpty == false {
            let count = currentModel?.images!.count ?? 0
            var width = Double(UIScreen.main.bounds.size.width - 62.auto() * 2/*左间距+右间距*/)
            let itemWidth = (width - 5*3/*内边距*/) / 3
            var height = 0.0
            let row = count/3 + (count % 3 > 0 ? 1 : 0)
            height = itemWidth * Double(row) + Double((row - 1) * 5/*内边距*/)
            let imageH = width / (120 / 160)
            if currentModel?.images?.count == 1 {
                height = imageH < width ? imageH : width
            } else if currentModel?.images?.count == 4 {
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
        blogLayout.children = flexbox as! [ASLayoutElement]
        
        let contentLayout = ASStackLayoutSpec.horizontal()
        contentLayout.spacing = 10
        contentLayout.justifyContent = .start
        contentLayout.alignItems = .start
        contentLayout.children = [
            iconNode,
            blogLayout
        ]
        
        nameNode.style.spacingBefore = 4
        textNode.style.spacingBefore = 6
        imagesNode.style.spacingBefore = 10
        bottomLayout.style.spacingBefore = 5
        
        if currentModel.likeList == nil && currentModel.commentList == nil {
            let resultLayout = ASStackLayoutSpec.vertical()
            resultLayout.spacing = 0
            resultLayout.justifyContent = .start
            resultLayout.alignItems = .stretch
            resultLayout.children = [
                ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10), child: contentLayout),
                botlineNode
            ]
            return resultLayout
        } else {
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10), child: contentLayout)
        }
    }
}
