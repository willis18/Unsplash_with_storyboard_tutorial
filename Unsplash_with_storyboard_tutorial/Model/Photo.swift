//
//  Photo.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 김송현 on 2021/04/15.
//

import Foundation

struct Photo : Codable {
    var thumbnail : String
    var username : String
    var likesCount : Int
    var createdAt : String
    
}
