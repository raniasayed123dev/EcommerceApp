//
//  OnBoardingView.swift
//  EcommerceApp
//
//  Created by rania on 01/09/2026.
//


import SwiftUI

struct OnBoardingView: View {

    @State private var currentPage = 0

    var body: some View {
        ZStack {

            Color.white
                .ignoresSafeArea()

            TabView(selection: $currentPage) {

                ForEach(onBoardingData.indices, id: \.self) { index in

                    let page = onBoardingData[index]

                    GeometryReader { geometry in

                        VStack {

                            Image(page.image)
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: geometry.size.width * 0.9,
                                    height: geometry.size.height * 0.6
                                )
                                .clipShape(OnBoardingImageShape())

                            Spacer()

                            VStack(alignment: .leading, spacing: 10) {

                                Text(page.title)
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.black)

                                Text(page.description)
                                    .font(.headline)
                                    .foregroundColor(Color.black.opacity(0.5))

                                HStack {

                                    HStack(spacing: 8) {

                                        ForEach(
                                            onBoardingData.indices,
                                            id: \.self
                                        ) { indicatorIndex in

                                            if indicatorIndex == currentPage {
                                                Capsule()
                                                    .frame(width: 25, height: 8)
                                            } else {
                                                Circle()
                                                    .frame(width: 8, height: 8)
                                            }
                                        }
                                    }

                                    Spacer()

                                    Button {

                                        if currentPage < onBoardingData.count - 1 {
                                            withAnimation {
                                                currentPage += 1
                                            }
                                        }

                                    } label: {

                                        Image(systemName: "arrow.right.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                    }
                                }
                                .foregroundStyle(.black)
                                .padding(.top, 20)
                            }

                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

#Preview {
    OnBoardingView()
}
