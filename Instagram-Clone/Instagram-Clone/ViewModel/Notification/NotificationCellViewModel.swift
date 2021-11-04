//
//  NotificationCellViewModel.swift
//  Instagram-Clone
//
//  Created by suthichai on 4/11/2564 BE.
//

import SwiftUI
import Firebase

class NotificationCellViewModel : ObservableObject {
    @Published var notification: Notification
    
    init(notification : Notification) {
        self.notification = notification
        fetchUser()
        fetchPost()
        checkFollow()
    }
    
    func fetchUser() {
        Firestore.firestore().collection("users").document(notification.uid).getDocument { (snap,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.notification.user = try? snap?.data(as: User.self)
        }
    }
    
    func fetchPost() {
        guard let postID = notification.postID else { return }
        
        Firestore.firestore().collection("posts").document(postID).getDocument { (snap,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.notification.post = try? snap?.data(as: Post.self)
        }
    }
    
    func follow() {
        if let didFollow = notification.didFollow , didFollow {
            return
        }
        guard let uid = notification.id else {
            return
        }
        UserService.follow(uid: uid) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            NotificationViewModel.sendNotification(withUID: uid, type: .follow)
            self.notification.didFollow = true
        }
    }
    
    func unfollow() {
        if let didFollow = notification.didFollow , !didFollow {
            return
        }
        guard let uid = notification.id else {
            return
        }
        
        UserService.unfollow(uid: uid) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.notification.didFollow = false
        }
    }
    
    func checkFollow() {
        guard let uid = notification.id else {
            return
        }
        UserService.checkFollow(uid: uid) { didFollow in
            self.notification.didFollow = didFollow
        }
    }
    
    var timestamp : String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [ .second , .minute , .hour , .day , .weekOfMonth]
        formatter.maximumUnitCount  = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue() , to:Date()) ?? ""
    }
    
}
