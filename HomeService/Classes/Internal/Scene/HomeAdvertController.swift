//
//  HomeAdvertController.swift
//  HomeService
//
//  Created by Logic on 2020/3/26.
//

import UIKit
import WebKit
import SnapKit

class HomeAdvertController: UIViewController {
    
    typealias CancleBlock = (_ touch: Bool) -> Void
    var cancleCallBack: CancleBlock!
    var hasTouch: Bool = false
     
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        kl_barShadowHidden = true
        kl_barAlpha = 0
        kl_tintColor = .white
        kl_swipeBackEnabled = false
        kl_clickBackEnabled = false
        let image = UIImage.image(named: "adverExit", in:Bundle(for: type(of: self)))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(backToViewController))
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(), style: .plain, target: nil, action: nil)

        view.addSubview(webView)
        webView.snp_makeConstraints { (make) in
             make.edges.equalToSuperview()
        }
        
        let url = "https://h5.m.jd.com/babelDiy/Zeus/3CM4ZYPLxAtaXjfmR2oM84GrP37M/index.html?app_home_xview=1&lng=113.954838&lat=22.541683&sid=f74a4ffd740ed8136027bf0bd208082w&un_area=19_1607_4773_0"
        webView.load(URLRequest(url: URL(string: url)!))
  
//        self.navigationController?.popViewController(animated: false)
//        if self.cancleCallBack != nil && self.hasTouch == false {
//            self.cancleCallBack(true)
//        }
     }
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hasTouch = true
        self.navigationController?.popViewController(animated: false)
        if self.cancleCallBack != nil {
           self.cancleCallBack(hasTouch)
        }
     }
     
     @objc func backToViewController() {
         hasTouch = false
         self.navigationController?.popViewController(animated: false)
         if self.cancleCallBack != nil {
            self.cancleCallBack(hasTouch)
         }
     }

     lazy var cancle = { () -> UIButton in
         let view = UIButton(type: .custom)
         return view
     }()

     lazy var webView = { () -> WKWebView in
         let config = WKWebViewConfiguration()
         let view = WKWebView(frame: .zero, configuration: config)
         view.isUserInteractionEnabled = false
         if #available(iOS 11.0, *) {
             view.scrollView.contentInsetAdjustmentBehavior = .never
         } else {
             self.automaticallyAdjustsScrollViewInsets = false
         }
         return view
     }()

}
