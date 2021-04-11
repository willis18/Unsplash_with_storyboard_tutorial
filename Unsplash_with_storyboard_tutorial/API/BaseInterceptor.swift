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
        <#code#>
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        <#code#>
    }
}
