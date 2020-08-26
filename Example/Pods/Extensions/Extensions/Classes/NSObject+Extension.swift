//
//  File.swift
//  Extensions
//
//  Created by Logic on 2020/3/13.
//

import Foundation
import UIKit

extension NSObject {

    /// 屏幕宽度
    public class func EXScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    /// 屏幕宽度
    public func EXScreenWidth() -> CGFloat {
        return NSObject.EXScreenWidth()
    }
    
    /// 屏幕高度
    public class func EXScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    /// 屏幕高度
    public func EXScreenHeight() -> CGFloat {
        return NSObject.EXScreenHeight()
    }
    
    /// 状态栏高度
    public class func EXStatusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    /// 状态栏高度
    public func EXStatusBarHeight() -> CGFloat {
        return NSObject.EXStatusBarHeight()
    }

    /// 导航栏高度
    public class func EXTopBarHeight() -> CGFloat {
        return EXStatusBarHeight() + 44.0
    }
    /// 导航栏高度
    public func EXTopBarHeight() -> CGFloat {
        return NSObject.EXTopBarHeight()
    }
    
    /// 选项栏高度
    public class func EXBottomSafeAreaInset() -> CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }
    /// 选项栏高度
    public func EXBottomSafeAreaInset() -> CGFloat {
        return NSObject.EXBottomSafeAreaInset()
    }

    /// iPhoneX底部安全高度
    public class func EXBottomBarHeight() -> CGFloat {
        return EXBottomSafeAreaInset() + 49.0
    }
    /// iPhoneX底部安全高度
    public func EXBottomBarHeight() -> CGFloat {
        return NSObject.EXBottomBarHeight()
    }

}
