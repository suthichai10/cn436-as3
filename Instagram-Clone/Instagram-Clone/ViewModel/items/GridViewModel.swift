//
//  GridViewModel.swift
//  Instagram-Clone
//
//  Created by suthichai on 3/11/2564 BE.
//

import SwiftUI
import Firebase

enum PostGridConfig {
    case explore
    case profile(String)
}

class GridViewModel: ObservableObject {
    @Published var posts = [Post]()
    let config: PostGridConfig
    
    init(config: PostGridConfig) {
        self.config = config
        fetchPosts()
    }
    func fetchPosts() {
        switch config {
        case .explore :
            fetchPostsExplorePage()
        case .profile(let uid) :
            fetchPostsProfile(withUID: uid)
        }
    }
    
    func fetchPostsExplorePage() {
        Firestore.firestore().collection("posts").getDocuments { (snap , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.posts = documents.compactMap{
                try? $0.data(as: Post.self)
            }
        }
    }
    
    func fetchPostsProfile(withUID uid: String) {
        Firestore.firestore().collection("posts").whereField("ownerUID" , isEqualTo: uid).getDocuments { (snap , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.posts = documents.compactMap{
                try? $0.data(as: Post.self)
            }
        }
    }
}

