//
//  HomeNavigationBarControl.swift
//  HomeService
//
//  Created by Logic on 2020/3/30.
//

import UIKit

class NavigationBarControl: NSObject {

    // MARK: - Lazy Load 
    lazy var navigationBar = { () -> NavigationBar in
        let view = NavigationBar()
        return view
    } ()
    
    lazy var navigationFooter = { () -> UIImageView in
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    } ()
        
    lazy var advertView = { () -> UIImageView in
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.alpha = 0
        return view
    } ()
}
