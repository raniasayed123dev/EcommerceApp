//
//  SplashScreen2View.swift
//  EcommerceApp
//
//  Created by rania on 03/09/2026.
//

import SwiftUI

struct SplashScreen2View: View {
    @State private var selectedButton = "Log In"
    var body: some View {
        ZStack{
            Image("splashImage2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            GeometryReader { geometry
                in

                VStack {
                    Spacer()

                    Image("logoImage1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 90)
                    Spacer()

                    VStack(spacing: 15) {

                        Button {
                            selectedButton = "Log In"
                        } label: {
                            Text("Log In")
                                .font(.headline)
                                .foregroundStyle(selectedButton == "Log In" ? .black :.white)
                                .frame(maxWidth: .infinity)
                                .frame(height : 55)
                                .background(
                                    selectedButton == "Log In" ? .white : .clear
                                )
                                .overlay{
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(.white,lineWidth: 2)

                                }

                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }

                        Button {
                            selectedButton = "Sign Up"
                        } label: {
                            Text("Sign Up")
                                .font(.headline)
                                .foregroundStyle(selectedButton == "Sign Up" ? .black :.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(
                                    selectedButton == "Sign Up" ? .white : .clear
                                )
                                .overlay{
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(.white,lineWidth: 2)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                    }

                }

                .padding(.horizontal ,geometry.size.width * 0.10)
                .padding(.bottom , 50)
            }
        }
    }
}

#Preview {
    SplashScreen2View()
}
