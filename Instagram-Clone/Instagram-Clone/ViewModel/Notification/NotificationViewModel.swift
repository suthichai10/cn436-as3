//
//  NotificationViewModel.swift
//  Instagram-Clone
//
//  Created by suthichai on 3/11/2564 BE.
//

import SwiftUI
import Firebase

class NotificationViewModel : ObservableObject {
    @Published var notification = [Notification]()
    
    init() {
        fetchNotifications()
    }
    
    func fetchNotifications() {
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("notifications").document(userID).collection("user-notifications").getDocuments { (snap , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            self.notification = documents.compactMap { try? $0.data(as: Notification.self) }
        }
    }
    
    static func sendNotification(withUID uid: String , type: NotificationType , post : Post? = nil) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let userID = user.id else { return }
        
        var data : [String:Any] = [
            "timestamp" : Timestamp(date: Date()),
            "username" : user.username,
            "uid" : userID,
            "profileImageURL": user.profileImageURL as Any,
            "type" : type.rawValue
        ]
        
        if let post = post, let id = post.id {
            data["postID"] = id
        }
        
        Firestore.firestore().collection("notifications").document(uid).collection("user-notifications").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
}
