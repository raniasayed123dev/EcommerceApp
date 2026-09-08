//
//  SignUpView.swift
//  EcommerceApp
//
//  Created by rania on 03/09/2026.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var isAgreed: Bool = false
    @State private var isSignUpPressed = false
    @State private var navigateToSuccess = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    
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
                    
                    // Title
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Sign up")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.black)
                        
                        Text("Create a new account")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                    
                    Spacer()
                        .frame(height: 50)
                    
                    // Text Fields
                    AuthTextField(
                        title: "User Name",
                        placeholder: "Enter your name",
                        isSecure: false,
                        text: $name
                    )
                    
                    Rectangle()
                        .foregroundStyle(.gray)
                        .frame(height: 0.3)
                    
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
                    
                    AuthTextField(
                        title: "Confirm Password",
                        placeholder: "Enter your Password",
                        isSecure: true,
                        text: $password
                    )
                    
                    Rectangle()
                        .foregroundStyle(.gray)
                        .frame(height: 0.3)
                    
                    Spacer()
                    
                    // Terms & Conditions
                    HStack(spacing: 20) {
                        Button {
                            isAgreed.toggle()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(
                                        isAgreed ? Color.black : Color.gray,
                                        lineWidth: 1
                                    )
                                    .frame(width: 20, height: 20)
                                
                                if isAgreed {
                                    Image(systemName: "checkmark")
                                        .font(.caption2)
                                        .foregroundStyle(.green)
                                }
                            }
                        }
                        
                        Text("By creating an account you have to agree with our them & condication.")
                            .foregroundStyle(
                                isAgreed ? Color.black : Color.gray
                            )
                    }
                    
                    // Sign Up Button
                    VStack(alignment: .center, spacing: 16) {
                        Button {
                            isSignUpPressed = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                navigateToSuccess = true
                            }
                        } label: {
                            Text("Sign Up")
                                .font(.headline)
                                .foregroundStyle(
                                    isSignUpPressed ? .black : .white
                                )
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    isSignUpPressed ? .white : .black
                                )
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 30)
                                )
                                .overlay {
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(.black, lineWidth: 1)
                                }
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 50)
                }
                .padding(.bottom, 70)
                .padding(.horizontal, 16)
                .padding(.top, 10)
            }
            .navigationDestination(isPresented: $navigateToSuccess) {
                AccountSuccessView()
            }
            .onAppear {
                isSignUpPressed = false
            }
            .padding(.top, 10)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SignUpView()
}
