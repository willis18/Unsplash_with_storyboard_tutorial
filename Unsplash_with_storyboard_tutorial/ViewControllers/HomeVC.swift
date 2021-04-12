//
//  ViewController.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 김송현 on 2021/03/25.
//

import UIKit
import Toast_Swift
import Alamofire

class HomeVC: UIViewController, UISearchBarDelegate, UIGestureRecognizerDelegate {

    @IBOutlet var searchFilterSegment: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchIndicator: UIActivityIndicatorView!
    var keyboardDismissTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:  nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //ui 설정
        self.config()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.searchBar.becomeFirstResponder() //포커싱 주기
    }
    // 화면이 넘어가기전 준비
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        
        case SEGUE_ID.USER_LIST_VC:
            //다음화면의 뷰 컨트롤러
            let nextVC = segue.destination as! UserListVC
            guard let userInputValue = self.searchBar.text else {return}
            nextVC.vcTitle = userInputValue
        
        case SEGUE_ID.PHOTO_COLLECTION_VC:
            let nextVC = segue.destination as! PhotoCollectionVC
            guard let userInputValue = self.searchBar.text else {return}
            nextVC.vcTitle = userInputValue
            
        default: print("default")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //키보드 올라가는 이벤트를 받는 처리
        //키보드 노티피케이션 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowHandle(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideHandle), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //키보드 노티피케이션 해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
        super.viewWillDisappear(animated)
    }
    //MARK: - fileprivate method
    fileprivate func config(){
        //ui 설정
        self.searchButton.layer.cornerRadius = 10
        self.searchBar.searchBarStyle = .minimal
        self.searchBar.delegate = self
        self.keyboardDismissTapGesture.delegate = self
        //제스처 추가하기
        self.view.addGestureRecognizer(keyboardDismissTapGesture)
        
    }
    fileprivate func pushVC(){
        var segueId = ""
        
        switch searchFilterSegment.selectedSegmentIndex {
        case 0:
            segueId = "goToPhotoCollectionVC"
        case 1:
            segueId = "goToUserListVC"
        default:
            segueId = "goToPhotoCollectionVC"
        }
        //화면 이동
        self.performSegue(withIdentifier: segueId, sender: self)
    }
    
    @objc func keyboardWillShowHandle(notification : NSNotification){
        //키보드 사이즈 가져오기
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            print("keyboardSize = \(keyboardSize.height)")
            print("searchButton.frame.origin.y: \(searchButton.frame.origin.y)")
            
            if(keyboardSize.height < searchButton.frame.origin.y){
                print("키보드가 버튼을 덮었다")
                let distance = keyboardSize.height - searchButton.frame.origin.y
                self.view.frame.origin.y = distance
            }
        }
    }
    
    @objc func keyboardWillHideHandle(){
        
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
        //self.searchBar.becomeFirstResponder() // 포커싱(자동으로 클릭 느낌?) 주기
        //self.searchBar.resignFirstResponder() 포커싱 해제
    }
    
    @IBAction func onSearchButtonClicked(_ sender: UIButton) {
        let url = API.BASE_URL + "search/photos"
        guard let userInput = self.searchBar.text else {return}
        //키, 벨류 딕셔너리
        let quaryParam =  ["quary" : userInput, "client_id" : API.CLIENT_ID]
//        AF.request(url, method: .get, parameters: quaryParam).responseJSON(completionHandler: {
//            respons in debugPrint(respons)
//        })
        MyAlamofireManager
            .shared
            .session
            .request(url)
            .responseJSON(completionHandler: {
                response in debugPrint(response)
                
            })
        //화면으로 이동
//        pushVC()
    }
    
    //MARK: - UISearchBar Delegate methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let userInputString = searchBar.text else { return }
        
        if userInputString.isEmpty{
            // toast with a specific duration and position
            self.view.makeToast("😓검색 키워드를 입력해주세요", duration: 3.0, position: .center)
        }else{
            pushVC()
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            self.searchButton.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now()+0.01, execute: {
                //포커싱 해제
                searchBar.resignFirstResponder()
                
            })
        }else{
            self.searchButton.isHidden = false 
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputTextCount = searchBar.text?.appending(text).count ?? 0
        print("shouldChangeTextIn = \(inputTextCount)")
        
        if(inputTextCount > 12){
            // toast with a specific duration and position
            self.view.makeToast("🙅‍♂️12자 이상 입력 불가", duration: 3.0, position: .center)
        }
        
//        if(inputTextCount<=12){
//            return true
//        }else{
//            return false
//        }
        //or
        return inputTextCount<=12 //바로 true,false 값가능
        
    }
    
    //MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if(touch.view?.isDescendant(of: searchFilterSegment) == true)
        {
            return false
        }else if(touch.view?.isDescendant(of: searchBar) == true){
            return false
        }else{
            view.endEditing(true)
            return true
        }
    }
}
