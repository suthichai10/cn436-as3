//
//  NotificationView.swift
//  Instagram-Clone
//
//  Created by suthichai on 1/11/2564 BE.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var viewModel = NotificationViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.notification) { notification in
                    NotificationCell(viewModel : NotificationCellViewModel(notification: notification))
                        .padding(.top)
                }
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
