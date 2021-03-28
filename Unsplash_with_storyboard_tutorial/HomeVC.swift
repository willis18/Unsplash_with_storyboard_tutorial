//
//  ViewController.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 김송현 on 2021/03/25.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet var searchFilterSegment: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //ui 설정
        self.searchButton.layer.cornerRadius = 10
        self.searchBar.searchBarStyle = .minimal
        
    }

    //MARK: - IBAction method
    @IBAction func searchFileterValueChanged(_ sender: UISegmentedControl){
        var searchTitle = ""
        
        switch sender.selectedSegmentIndex {
        case 0:
            searchTitle = "사진 키워드"
        case 1:
            searchTitle = "사용자 이름"
        default:
            searchTitle = "사진 키워드"
        }
        self.searchBar.placeholder = searchTitle + " 입력"
        self.searchBar.becomeFirstResponder() // 포커싱(자동으로 클릭 느낌?) 주기
        //self.searchBar.resignFirstResponder() 포커싱 해제
    }
    
    @IBAction func onSearchButtonClicked(_ sender: UIButton) {
        var segueId = ""
        
        switch searchFilterSegment.selectedSegmentIndex {
        case 0:
            segueId = "goToPhotoCollectionVC"
        case 1:
            segueId = "goToUserListVC"
        default:
            segueId = "goToPhotoCollectionVC"
        }
        self.performSegue(withIdentifier: segueId, sender: self)
    }
}

