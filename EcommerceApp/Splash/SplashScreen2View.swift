//
//  SplashScreen2View.swift
//  EcommerceApp
//
//  Created by rania on 03/09/2026.
//

import SwiftUI

struct SplashScreen2View: View {
   
    var body: some View {
        NavigationStack {
    
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
                            
                            NavigationLink {
                                                           LoginView()
                                                       } label: {
                                                           Text("Login")
                                                               .font(.headline)
                                                               .foregroundStyle(.black)
                                                               .frame(maxWidth: .infinity)
                                                               .padding()
                                                               .background(.white)
                                                               .clipShape(
                                                                   RoundedRectangle(cornerRadius: 30))
                                                       }
                                                       
                                                       NavigationLink {
                                                           SignUpView()
                                                       } label: {
                                                           Text("Sign Up")
                                                               .font(.headline)
                                                               .foregroundStyle(.black)
                                                               .frame(maxWidth: .infinity)
                                                               .padding()
                                                               .background(.white)
                                                               .clipShape(
                                                                   RoundedRectangle(cornerRadius: 30))
                                                    }
                        }
                    }
                    
                    .padding(.horizontal ,geometry.size.width * 0.10)
                    .padding(.bottom , 50)
                    .padding(.top ,120)
                }
            }
        }
    }
}

#Preview {
    SplashScreen2View()
}
