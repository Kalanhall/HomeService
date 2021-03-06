//
//  HomeGraphicController.swift
//  HomeService
//
//  Created by Kalan on 2020/8/25.
//

import UIKit
import AsyncDisplayKit
import SnapKit

class CommentModel: NSObject {
    var iconURL: String?
    var nickName: String?
    var text: String?
    var images: [String]?
    var address: String?
    var time: String?
    var likeList: [String]?
    var commentList: [String]?
    
    func commentRows() -> Int {
        var rows: Int = 0
        if likeList != nil  {
            rows = rows + 1
        }
        if commentList != nil {
            rows = rows + commentList!.count
        }
        return rows
    }
}

class HomeGraphicController: JXSegmentController, ASTableDelegate, ASTableDataSource {
    var controllerIndex = 0
    var dataSource: [CommentModel]? = []
    
    lazy var tableNode: ASTableNode = {
        var tableNode = ASTableNode()
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.separatorStyle = .none
        tableNode.view.showsVerticalScrollIndicator = false
        return tableNode
    }()
    
    // 初始化方法
    class func controller(index: Int) -> HomeGraphicController {
        let vc = HomeGraphicController()
        vc.controllerIndex = index;
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for item in 0...9 {
            let model = CommentModel()
            model.iconURL = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598532482335&di=0d5afbdafe006a8c3d42191794afd8b9&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D0241830ebe014a90813e46b599763971%2F6d2aaa4bd11373f09e545323a30f4bfbfaed048f.jpg"
            model.nickName = "微信朋友圈"
            model.text = "近平总书记对垃圾分类做出重要指示，强调实行垃圾分类，关系广大人民群众生活环境，关系节约使用资源。"
            var images = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598532482335&di=0d5afbdafe006a8c3d42191794afd8b9&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D0241830ebe014a90813e46b599763971%2F6d2aaa4bd11373f09e545323a30f4bfbfaed048f.jpg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598532482335&di=0d5afbdafe006a8c3d42191794afd8b9&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D0241830ebe014a90813e46b599763971%2F6d2aaa4bd11373f09e545323a30f4bfbfaed048f.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598532482335&di=0d5afbdafe006a8c3d42191794afd8b9&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D0241830ebe014a90813e46b599763971%2F6d2aaa4bd11373f09e545323a30f4bfbfaed048f.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598532482335&di=0d5afbdafe006a8c3d42191794afd8b9&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D0241830ebe014a90813e46b599763971%2F6d2aaa4bd11373f09e545323a30f4bfbfaed048f.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598532482335&di=0d5afbdafe006a8c3d42191794afd8b9&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D0241830ebe014a90813e46b599763971%2F6d2aaa4bd11373f09e545323a30f4bfbfaed048f.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598532482335&di=0d5afbdafe006a8c3d42191794afd8b9&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D0241830ebe014a90813e46b599763971%2F6d2aaa4bd11373f09e545323a30f4bfbfaed048f.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598532482335&di=0d5afbdafe006a8c3d42191794afd8b9&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D0241830ebe014a90813e46b599763971%2F6d2aaa4bd11373f09e545323a30f4bfbfaed048f.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598532482335&di=0d5afbdafe006a8c3d42191794afd8b9&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D0241830ebe014a90813e46b599763971%2F6d2aaa4bd11373f09e545323a30f4bfbfaed048f.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598532482335&di=0d5afbdafe006a8c3d42191794afd8b9&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3D0241830ebe014a90813e46b599763971%2F6d2aaa4bd11373f09e545323a30f4bfbfaed048f.jpg"]
            model.images = Array(images[0..<item])
            model.address = "深圳·宝安区·财富港大厦"
            model.time = "1小时前 Wechat"
            model.likeList = ["非死不可1", "非死不可2","非死不可3","非死不可4","FackBook~"]
            model.commentList = ["非死不可：这是一条评论", "FackBook回复非死不可：这是第2条评论这是第2条评论这是第2条评论", "非死不可回复FackBook：这是第3条评论这是第3条评论这是第3条评论"]
            
            self.dataSource?.append(model)
        }
        
        view.addSubnode(tableNode)
        tableNode.view.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        let model = dataSource?[section]
        return model!.commentRows() + 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let model = dataSource?[indexPath.section]
        if indexPath.row == 0 {
            let block = { [weak self] () -> ASCellNode in
                let cell = HomeGraphicCell(model: model!)
                return cell
            }
            return block
        } else {
            let block = { [weak self] () -> ASCellNode in
                let cell = HomeTichTextCell(model: model!)
                return cell
            }
            return block
        }
    }
    
}
