//
//  Extensions.swift
//  Instagram-Clone
//
//  Created by suthichai on 2/11/2564 BE.
//

import SwiftUI
import UIKit
import Kingfisher

extension Image {
    func resizeTo(width:CGFloat , height:CGFloat) -> some View {
        self.resizable()
            .scaledToFill()
            .frame(width: width , height:height)
    }
}

extension KFImage {
    func resizeTo(width:CGFloat , height:CGFloat) -> some View {
        self.resizable()
            .scaledToFill()
            .frame(width: width , height:height)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil , from: nil , for: nil)
    }
}
