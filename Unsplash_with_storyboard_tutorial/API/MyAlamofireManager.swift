//
//  MyAlamofireManager.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 김송현 on 2021/04/11.
//

import Foundation
import Alamofire
import SwiftyJSON

final class MyAlamofireManager{
    // 싱글톤 적용
    static let shared = MyAlamofireManager()
    //인터셉터
    let interseptors = Interceptor(interceptors:
        [
            BaseInterceptor()
        ])
    // 로거 설정
    let monitors = [MyLogger(), MyApiStatusLogger()] as [EventMonitor]
    //세션 설정
    var session : Session
    private init(){
        session = Session(interceptor: interseptors, eventMonitors: monitors)
    }
 
    func getPhotos(searchTerm userInput : String, completion: @escaping(Result<[Photo],MyError >) -> Void){
        
        self.session
            .request(MySearchRouter.searchPhotos(term: userInput))
            .validate(statusCode: 200..<401)
            .responseJSON(completionHandler: { response in
                
                guard let responseValue = response.value else {return}
                
                let responseJson = JSON(response.value!)
                
                let jsonArray = responseJson["results"]
                
                var photos = [Photo]()
                
                for(index, subJson): (String, JSON) in jsonArray{
                    //데이터 파싱
                    let photoItem = Photo(thumbnail: <#T##String#>, username: <#T##String#>, likesCount: <#T##Int#>, createdAt: <#T##String#>)
                    //배열에 넣고
                     
                }
                
            })
    }
}
