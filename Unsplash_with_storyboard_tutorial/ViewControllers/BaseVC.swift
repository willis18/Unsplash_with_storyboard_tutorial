//
//  BaseVC.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 김송현 on 2021/04/05.
//

import UIKit

class BaseVC: UIViewController{
    var vcTitle : String = ""{
        didSet{
            self.title = vcTitle
        }
    }
}
