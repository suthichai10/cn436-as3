//
//  FeedCellViewModel.swift
//  Instagram-Clone
//
//  Created by suthichai on 3/11/2564 BE.
//

import SwiftUI
import Firebase

class FeedCellViewModel: ObservableObject {
    @Published var post : Post
    
    init(post: Post) {
        self.post = post
        fetchUser()
        checkLike()
    }
    
    func like() {
        if let didLike = post.didLike , didLike {
            return
        }
        guard let postID = post.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("posts").document(postID).collection("post-likes").document(userID).setData([:]) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("users").document(userID).collection("user-likes").document(postID).setData([:]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                Firestore.firestore().collection("posts").document(postID).updateData([
                    "likes" : self.post.likes + 1
                ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }
                
                NotificationViewModel.sendNotification(withUID: self.post.ownerUID, type: .like)
                self.post.likes += 1
                self.post.didLike = true
            }
        }
    }
    
    func unLike() {
        if let didLike = post.didLike , !didLike {
            return
        }
        guard let postID = post.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("posts").document(postID).collection("post-likes").document(userID).delete() { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("users").document(userID).collection("user-likes").document(postID).delete() { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                Firestore.firestore().collection("posts").document(postID).updateData([
                    "likes" : self.post.likes - 1
                ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }
                self.post.likes -= 1
                self.post.didLike = false
            }
        }
    }
    
    func checkLike() {
        guard let postID = post.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("posts").document(postID).collection("post-likes").document(userID).getDocument { (snap , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let didLike = snap?.exists else { return }
            self.post.didLike = didLike
        }
    }
    
    func fetchUser() {
        Firestore.firestore().collection("users").document(post.ownerUID).getDocument { (snap , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.post.user = try? snap?.data(as: User.self)
            
            guard let userImageURL = self.post.user?.profileImageURL else { return }
            
            self.post.ownerImageURL = userImageURL
        }
    }
    
    var timestamp : String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [ .second , .minute , .hour , .day , .weekOfMonth]
        formatter.maximumUnitCount  = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: post.timestamp.dateValue() , to:Date()) ?? ""
    }
    
    var likeText : String {
        let label = post.likes == 1 ? "like" : "likes"
        return "\(post.likes) \(label)"
    }
}
