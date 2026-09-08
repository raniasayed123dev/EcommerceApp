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
    @State private var  isLoginPressed : Bool = false
    @State private var navigateToHome = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack {
                    
                    // Back Button
                    HStack {
                        
                        Button {
                            dismiss()
                        } label: {
                            ZStack {
                                
                                Circle()
                                    .fill(.black)
                                    .frame(width: 45, height: 45)
                                
                                Image("backButtonArrow")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }
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
                        
                        Spacer()
                        Button {
                            isLoginPressed = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                navigateToHome = true
                            }
                        } label: {
                            Text("Login")
                                .font(.headline)
                                .foregroundStyle(
                                    isLoginPressed ? .white : .black
                                )
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    isLoginPressed ? .black : .white
                                )
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 30)
                                )
                                .overlay {
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(.black, lineWidth: 1)
                                }
                        }
                        
                    
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
            .navigationDestination(isPresented: $navigateToHome) {
                HomeView()
            }
            .onAppear {
                isLoginPressed = false
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

