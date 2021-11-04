//
//  User.swift
//  Instagram-Clone
//
//  Created by suthichai on 2/11/2564 BE.
//

import Firebase
import FirebaseFirestoreSwift

struct User: Decodable , Identifiable {
    let username : String
    let email: String
    let fullname: String
    var profileImageURL: String?
    @DocumentID var id : String?
    
    var stats : UserStatData?
    
    mutating func updateProfileImageURL(url: String) {
        profileImageURL = url
    }
    
    var isCurrentUser: Bool {
        AuthViewModel.shared.userSession?.uid == id
    }
    
    var didFollow: Bool? = false
    var bio: String?
}

struct UserStatData : Decodable {
    var following : Int
    var followers : Int
    var posts : Int
}
