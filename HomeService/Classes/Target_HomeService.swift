//
//  HomeService.swift
//  HomeService
//
//  Created by Logic on 2020/3/13.
//

import UIKit

@objc class Target_HomeService: NSObject {
    
    @objc func Action_nativeToFetchHomeViewController(_ parameters: NSDictionary) -> UIViewController {
        let vc = HomeViewController()
        return vc;
    }
    
    
}
