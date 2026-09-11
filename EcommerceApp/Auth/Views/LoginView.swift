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
    @State private var selectedButton = "Log In"
    @Environment(\.dismiss) private var dismiss
    @State private var authViewModel = AuthViewModel()

    private var isLoginValid: Bool {
        AuthValidator.validateEmail(email) == nil &&
        !password.isEmpty
    }

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            ScrollView {
                VStack {

                    // Back Button
                    HStack {
                        BackButton {
                            dismiss()
                        }

                        Spacer()
                    }
                    .padding(.horizontal, 10)

                    // Logo
                    Image("logoImage2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 136, height: 83)

                    // Login Content
                    VStack(alignment: .leading, spacing: 10) {

                        Text("Welcome Back")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.black)

                        Text("please login or sign up to continue our app")
                            .font(.subheadline)
                            .foregroundStyle(.gray)

                        Spacer()
                            .frame(height: 50)

                        AuthTextField(
                            title: "Email",
                            placeholder: "Enter your email",
                            isSecure: false,
                            text: $email
                        )

                        Rectangle()
                            .foregroundStyle(.gray)
                            .frame(height: 0.3)

                        AuthTextField(
                            title: "Password",
                            placeholder: "Enter your Password",
                            isSecure: true,
                            text: $password
                        )

                        Rectangle()
                            .foregroundStyle(.gray)
                            .frame(height: 0.3)

                        if !authViewModel.errorMessage.isEmpty {
                            Text(authViewModel.errorMessage)
                                .font(.caption)
                                .foregroundStyle(.red)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading
                                )
                        }

                        Spacer()

                        // Login Button
                        Button {

                            let isValid = authViewModel.validateLogin(
                                email: email,
                                password: password
                            )

                            if !isValid {
                                return
                            }

                            Task {
                                let success = await authViewModel.login(
                                    email: email,
                                    password: password
                                )

                                if success {
                                    SessionManager.shared.completeLogin()
                                }
                            }

                        } label: {
                            Text("Login")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.black)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 30)
                                )
                        }
                        .disabled(!isLoginValid)
                        .opacity(isLoginValid ? 1 : 0.5)

                        Rectangle()
                            .foregroundStyle(.gray)
                            .frame(height: 0.3)
                            .overlay {
                                Text("or")
                                    .font(.title2)
                            }

                        AuthButton(
                            title: "Continue with Facebook",
                            backgroundColor: selectedButton == "Continue with Facebook"
                                ? Color.black
                                : Color.white,
                            textColor: selectedButton == "Continue with Facebook"
                                ? Color.white
                                : Color.black,
                            hasBorder: true
                        ) {
                            selectedButton = "Continue with Facebook"
                        }

                        AuthButton(
                            title: "Continue with Google",
                            backgroundColor: selectedButton == "Continue with Google"
                                ? Color.black
                                : Color.white,
                            textColor: selectedButton == "Continue with Google"
                                ? Color.white
                                : Color.black,
                            hasBorder: true
                        ) {
                            selectedButton = "Continue with Google"
                        }

                        AuthButton(
                            title: "Continue with Apple",
                            backgroundColor: selectedButton == "Continue with Apple"
                                ? Color.black
                                : Color.white,
                            textColor: selectedButton == "Continue with Apple"
                                ? Color.white
                                : Color.black,
                            hasBorder: true
                        ) {
                            selectedButton = "Continue with Apple"
                        }
                    }
                    .padding(.horizontal, 30)
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
                .padding(.bottom, 40)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.top, 20)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LoginView()
}
