//
//  MyApiStatusLogger.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 김송현 on 2021/04/13.
//

import Foundation
import Alamofire

final class MyApiStatusLogger : EventMonitor{
    let queue = DispatchQueue(label:"MyApiStatusLogger")
    
//    func requestDidResume(_ request: Request) {
//        debugPrint(request)
//    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        guard let statusCode = request.response?.statusCode else {return}
        print("MyApiStatusLogger - status : \(statusCode)")
//        debugPrint(response)
    }
}
