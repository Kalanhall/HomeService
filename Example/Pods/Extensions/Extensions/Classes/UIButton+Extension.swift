//
//  UIButton+Extension.swift
//  Extensions
//
//  Created by Logic on 2019/11/14.
//

import Foundation

public enum ButtonLayoutType {
    case normal
    case right
    case top
    case bottom
}

public extension UIButton {
    
    func layout(with type: ButtonLayoutType, margin: CGFloat) {
        let iw = self.imageView?.bounds.size.width ?? 0
        let ih = self.imageView?.bounds.size.width ?? 0
        var lw = self.titleLabel?.bounds.size.width ?? 0
        let lh = self.titleLabel?.bounds.size.width ?? 0
        
        
        if let text = self.titleLabel?.text {
            let ts = text.size(withAttributes: [.font : self.titleLabel?.font ?? UIFont.systemFont(ofSize: 15)])
            let fs = CGSize(width: CGFloat(ceilf(Float(ts.width))), height: CGFloat(ceilf(Float(ts.height))))
            
            if lw < fs.width {
                lw = fs.width
            }
            
            let kmargin = margin/2.0
            switch type {
                case .normal:
                    self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -kmargin, bottom: 0, right: kmargin)
                    self.titleEdgeInsets = UIEdgeInsets(top: 0, left: kmargin, bottom: 0, right: -kmargin)
                        break
                    
                    case .right:
                        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: lw+kmargin, bottom: 0, right: -lw-kmargin)
                        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -iw-kmargin, bottom: 0, right: iw+kmargin)
                        break
                            
                    case .top:
                        // 10为Button默认间距补偿
                        self.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: lh+margin, right: -lw)
                        self.titleEdgeInsets = UIEdgeInsets(top: ih+margin, left: -iw, bottom: 0, right: 0)
                        break
                                
                    case .bottom:
                        // 10为Button默认间距补偿
                        self.imageEdgeInsets = UIEdgeInsets(top: lh+margin, left: 0, bottom: 0, right: -lw)
                        self.titleEdgeInsets = UIEdgeInsets(top: -10, left: -iw, bottom: ih+margin, right: 0)
                        break
                
            }
        }
    }
}
