//
//  EditProfileViewModel.swift
//  Instagram-Clone
//
//  Created by suthichai on 4/11/2564 BE.
//

import SwiftUI
import Firebase

class EditProfileViewModel : ObservableObject {
    @Published var uploadComplete = false
    var user: User
    
    init(user : User) {
        self.user = user
    }
    
    func saveBio(bio: String) {
        guard let userID = user.id else { return }
        
        Firestore.firestore().collection("users").document(userID).updateData(["bio":bio]) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.user.bio = bio
            self.uploadComplete = true
        }
    }
}
