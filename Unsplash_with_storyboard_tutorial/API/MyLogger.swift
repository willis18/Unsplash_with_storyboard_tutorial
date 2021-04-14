//
//  MyLogger.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 김송현 on 2021/04/12.
//

import Foundation
import Alamofire

final class MyLogger : EventMonitor{
    let queue = DispatchQueue(label:"MyLogger")
    
    func requestDidResume(_ request: Request) {
        debugPrint(request)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        debugPrint(response)
    }
}
