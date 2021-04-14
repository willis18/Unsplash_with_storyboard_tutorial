//
//  Constants.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 김송현 on 2021/04/04.
//

import Foundation

enum SEGUE_ID{
    static let USER_LIST_VC = "goToUserListVC"
    static let PHOTO_COLLECTION_VC = "goToPhotoCollectionVC"
    
}

enum API{
    static let BASE_URL : String = "https://api.unsplash.com/"
    static let CLIENT_ID : String = "YyJdVt0NH94u3PwARi9SCgMZJzzurOqJ0pzcciSPgHY"
}

enum NOTIFICATION{
    enum API{
        static let AUTH_FAIL = "authentication_fail"
    }
}
