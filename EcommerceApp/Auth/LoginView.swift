//
//  LoginView.swift
//  EcommerceApp
//
//  Created by rania on 03/09/2026.
//

import SwiftUI

struct LoginView: View {

    @State private var email = ""
    @State private var password = ""
    var body: some View {

        ZStack {
            Color.white
                .ignoresSafeArea()
            ScrollView {

                VStack {
                    Spacer()
                        .frame(height: 25)

             Image("logoImage2")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)



                    VStack (alignment: .leading, spacing: 20) {
                        Text("Welcome Back")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.black)
                        Text("please login or sign up to continue our app")
                            .font(.headline)
                            .foregroundStyle(.gray)
                        Spacer()
                            .frame(height: 25)

                        AuthTextField(title: "Email",
                                      placeholder: "Enter your email",
                                      isSecure: false,
                                      text: $email)

                        AuthTextField(
                            title:"Password" ,
                            placeholder: "Enter your Password",
                            isSecure: true,
                            text: $password
                        )

                    }
                    .padding(.horizontal , 10)


                }

            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    LoginView()
}
