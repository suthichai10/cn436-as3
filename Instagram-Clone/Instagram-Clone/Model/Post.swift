//
//  Post.swift
//  Instagram-Clone
//
//  Created by suthichai on 3/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Post: Decodable , Identifiable {
    @DocumentID var id : String?
    let caption : String
    let timestamp : Timestamp
    var likes : Int
    let imageURL : String
    let ownerUID : String
    var ownerImageURL : String?
    let ownerUsername : String
    
    var user: User?
    var didLike: Bool? = false
}
