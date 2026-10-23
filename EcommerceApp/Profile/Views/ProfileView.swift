//
//  ProfileView.swift
//  EcommerceApp
//
//  Created by rania on 30/09/2026.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    var goBack: () -> Void
    
    @State private var viewModel = ProfileViewModel()
    @State private var showNameAlert = false
    @State private var editedName = ""
    @State private var showImagePicker = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    profileHeader
                        .padding(.bottom, 10)

                    profileCard

                    VStack(spacing: 0) {
                        profileRow(
                            imageName: "personalDetails",
                            title: "Personal Details"
                        ) {}

                        profileRow(
                            imageName: "orderImage",
                            title: "My Order"
                        ) {}

                        profileRow(
                            imageName: "FavouriteImage",
                            title: "My Favourites"
                        ) {}

                        profileRow(
                            imageName: "shippingAddress",
                            title: "Shipping Address"
                        ) {}

                        profileRow(
                            imageName: "settings",
                            title: "Settings"
                        ) {}
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                    )
                    .shadow(
                        color: .black.opacity(0.08),
                        radius: 8,
                        x: 0,
                        y: 2
                    )

                    logoutButton
                        .padding(.horizontal, 10)
                        .padding(.top, 30)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .scrollIndicators(.hidden)
        }
        .onAppear {
            viewModel.loadUser()
        }
        .alert("Edit Name", isPresented: $showNameAlert) {
            TextField("Enter your name", text: $editedName)

            Button("Cancel", role: .cancel) {}

            Button("Save") {
                viewModel.saveName(editedName)
            }
        } message: {
            Text("Enter your new name.")
        }
    }

    private var profileHeader: some View {
        ZStack {
            Text("Profile")
                .font(.title)
                .fontWeight(.semibold)

            HStack {
                BackButton {
                    goBack()
                }

                Spacer()
            }
        }
    }

    private var profileCard: some View {
        VStack(spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                Image("profileImage1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 28)
                    )

                Button {
                    showImagePicker = true
                } label: {
                    Image("editImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .padding(10)
                        .background(.white, in: Circle())
                        .shadow(
                            color: .black.opacity(0.1),
                            radius: 4,
                            x: 0,
                            y: 2
                        )
                }
                .padding(4)
            }

            HStack(spacing: 12) {
               Text(viewModel.displayName.isEmpty ? "Your Name" : viewModel.displayName)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)

                Button {
                    editedName = viewModel.displayName
                    showNameAlert = true
                } label: {
                    Image("editImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray.opacity(0.1))
                        )
                }
            }

           Text(viewModel.email)
                .font(.subheadline)
                .foregroundStyle(.gray)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
    }

   
    private func profileRow(
        imageName: String,
        title: String,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
        } label: {
            VStack(spacing: 0) {
                HStack(spacing: 15) {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray.opacity(0.2))
                        )

                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.black)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.subheadline)
                        .foregroundStyle(.black)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

                Divider()
                    .padding(.horizontal, 30)
            }
        }
    }

    private var logoutButton: some View {
        Button {
            SessionManager.shared.signOut()
        } label: {
            HStack {
                Spacer()

                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.headline)

                Text("Log Out")
                    .font(.headline)

                Spacer()
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.black)
            )
        }
    }
}

#Preview {
    ProfileView {}
}
