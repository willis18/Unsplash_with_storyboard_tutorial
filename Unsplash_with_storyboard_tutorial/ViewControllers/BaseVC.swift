//
//  BaseVC.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 김송현 on 2021/04/05.
//

import UIKit
import Toast_Swift

class BaseVC: UIViewController{
    var vcTitle : String = ""{
        didSet{
            self.title = vcTitle
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //인증 실패 노티피케이션 등록
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorPopup(notification:)), name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil)
    }
     
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //인증 실패 노티피케이션 등록 해제
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil)
    }
    
    //MARK: - objc method
    @objc func showErrorPopup(notification: Notification){
        if let data = notification.userInfo?["statusCode"]{
            print("showErroePopup : \(data)")
            
            DispatchQueue.main.async {
                self.view.makeToast("\(data)에러 입니다", duration: 1.5, position: .center)
            }
        }
    }
}
