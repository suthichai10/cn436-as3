//
//  ContentView.swift
//  Instagram-Clone
//
//  Created by suthichai on 1/11/2564 BE.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selectedIndex = 0
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                SigninView()
            } else {
                if let user = viewModel.currentUser {
                    MainView(user: user , selectedIndex: $selectedIndex)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel.shared)
    }
}
