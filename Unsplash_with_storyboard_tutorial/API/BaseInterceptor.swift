//
//  BaseInterceptor.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 김송현 on 2021/04/11.
//

import Foundation
import Alamofire

class BaseInterceptor : RequestInterceptor{
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        
        //공통 파라미터 추가
        var dictionary = [String:String]()
        dictionary.updateValue(API.CLIENT_ID, forKey: "client_id")
        do{
            request = try URLEncodedFormParameterEncoder().encode(dictionary, into: request)
        }catch{
            print(error)
        }
        
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}
