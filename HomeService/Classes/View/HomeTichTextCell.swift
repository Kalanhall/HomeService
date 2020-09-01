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
    var currentModel: CommentModel!
    
    init(model: CommentModel) {
        super.init()
        currentModel = model
        
        selectionStyle = .none
        textNode.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 10)
        textNode.backgroundColor = UIColor.color(hexNumber: 0xF7F7F7)
        addSubnode(textNode)
        
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var text = ""
        if currentModel.likeList != nil && indexPath?.row == 1 {
            // 有点赞，则第一条显示点赞
            text = "ෆ "
            for (index, item) in currentModel.likeList!.enumerated() {
                text.append(item)
                if index != currentModel.likeList!.count - 1 {
                    text.append("，")
                }
            }
        } else {
            // 没有点赞，则全部为评论
            text = currentModel.commentList?[((indexPath?.row ?? 0) - 1 - (currentModel.likeList?.isEmpty == true ? 0 : 1))] as! String
        }
        
        let para = NSMutableParagraphStyle()
        para.lineSpacing = 2
        textNode.attributedText = NSAttributedString(string: text,
                                                     attributes: [.font : UIFont.boldSystemFont(ofSize: 13),
                                                                  .paragraphStyle : para,
                                                                  .foregroundColor : UIColor.color(hexNumber: 0x000000)])
        
        var edgeInsets: UIEdgeInsets!
        if indexPath?.row == 1 { // 第一条
            textNode.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            if currentModel.likeList?.isEmpty == false {
                textNode.attributedText = NSAttributedString(string: text,
                                                             attributes: [.font : UIFont.boldSystemFont(ofSize: 13),
                                                                          .paragraphStyle : para,
                                                                          .foregroundColor : UIColor.color(hexNumber: 0x576B95)])
            }
        }
        if indexPath?.row == currentModel.commentRows() { // 最后一条
            edgeInsets = UIEdgeInsets(top: 0, left: 42.auto()+20, bottom: 10, right: 10)
        } else {
            edgeInsets = UIEdgeInsets(top: 0, left: 42.auto()+20, bottom: 0, right: 10)
        }
        return ASInsetLayoutSpec(insets: edgeInsets, child: textNode)
    }
}
