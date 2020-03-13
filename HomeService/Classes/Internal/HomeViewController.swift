//
//  HomeViewController.swift
//  HomeService
//
//  Created by Logic on 2020/3/13.
//  首页

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(push))
        
        
    }
    
    @objc func push() {
        let vc = HomeSpecialController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
