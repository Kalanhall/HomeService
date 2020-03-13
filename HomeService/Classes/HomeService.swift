//
//  HomeService.swift
//  HomeService
//
//  Created by Logic on 2020/3/13.
//

import UIKit

@objc class HomeService: NSObject {
    @objc func nativeToFetchHomeViewController(_ parameters: NSDictionary) -> UIViewController {
        let vc = HomeViewController()
        return vc;
    }
}
