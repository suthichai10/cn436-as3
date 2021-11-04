//
//  SigninView.swift
//  Instagram-Clone
//
//  Created by suthichai on 2/11/2564 BE.
//

import SwiftUI

struct SigninView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Image("instagram-text-logo")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 220)
                    .foregroundColor(.black)
                VStack(spacing: -16) {
                    CustomTextField(text:$email, placeholder: Text("Email") , imageName:"envelope")
                        .padding()
                        .padding(.horizontal , 32)
                    CustomSecureField(text:$password, placeholder: Text("Password"))
                        .padding()
                        .padding(.horizontal , 32)
                }
                HStack {
                    Spacer()
                    
                    NavigationLink(
                        destination: ForgotPasswordView(email: $email),
                        label: {
                            Text("Forgot Password")
                                .font(.system(size:13,weight:.semibold))
                                .foregroundColor(.gray)
                                .padding(.top)
                                .padding(.trailing,28)
                        }
                    )
                }
                .padding(.horizontal , 24)
                
                Button {
                    viewModel.signin(withEmail: email, password: password)
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width:360,height:50)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .padding()
                }
                Spacer()
                
                NavigationLink (
                    destination: RegisterView().navigationBarHidden(true), label: {
                        HStack {
                            Text("Don't have an account?")
                                .font(.system(size: 14 , weight: .semibold))
                            
                            Text("Register")
                                .font(.system(size: 14))
                        }
                    }
                )
            }
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
            .environmentObject(AuthViewModel.shared)
    }
}
