//
//  MyAlamofireManager.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 김송현 on 2021/04/11.
//

import Foundation
import Alamofire

final class MyAlamofireManager{
    // 싱글톤 적용
    static let shared = MyAlamofireManager()
    //인터셉터
    let interseptors = Interceptor(interceptors:
        [
            BaseInterceptor()
        ])
    // 로거 설정
//    let monitors
    //세션 설정
    var session : Session
    private init(){
        session = Session(interceptor: interseptors)
    }
    
}
