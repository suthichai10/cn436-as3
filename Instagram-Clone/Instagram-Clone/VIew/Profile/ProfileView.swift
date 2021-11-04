//
//  ProfileView.swift
//  Instagram-Clone
//
//  Created by suthichai on 1/11/2564 BE.
//

import SwiftUI

struct ProfileView: View {
    @State var user : User
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    ProfileHeaderView(viewModel: ProfileViewModel(user:user))
                }

                if let currentProfileID = user.id {
                    PostGridView(config:.profile(currentProfileID))
                }
            }
        }
    }
}
