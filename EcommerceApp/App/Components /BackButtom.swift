//
//  BackButtom.swift
//  EcommerceApp
//
//  Created by rania on 09/09/2026.
//

import Foundation
import SwiftUI

struct BackButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
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
    }
}

#Preview {
    BackButton {
        print("Back tapped")
    }
}
