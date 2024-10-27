//
//  CreateGroup.swift
//  rowdypay
//
//  Created by Khoi Tran on 10/26/24.
//

import SwiftUI

struct CreateGroup: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ViewModel
    @State private var name: String = ""
    @State private var imgStr: String = ""
    @State private var users: [Int] = []
    @State private var displayUsers: [User] = []
    @State private var createSuccess: Bool = false
    
    @State private var searchUserID = "" // For the search field
    @State private var showUserAlert: Bool = false
    @State private var showGroupAlert: Bool = false
    @State private var isSearching = false
//    let groupImages = ["group_image1", "group_image2", "group_image3", "group_image4", "group_image5"]

    var body: some View {
        VStack{
            TextField("Enter Group Name", text: $name)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray6))
                )
            
            HStack {
                TextField("Enter User ID", text: $searchUserID)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemGray6))
                    )
                
                Button("Add User") {
                    searchUser()
                }
                .disabled(searchUserID.isEmpty || isSearching)
            }
            
            // Display added users
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(displayUsers, id: \.self) { user in
                        VStack {
                            AsyncImage(url: URL(string: user.image)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } placeholder: {
                                Circle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 50, height: 50)
                            }
                            Text(user.username)
                                .font(.caption)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
            Button(action: {
                createGroup()
            }) {
                Text("Create Group")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.accent)
                            .shadow(
                                color: Color.accent.opacity(0.3),
                                radius: 8,
                                x: 0,
                                y: 4
                            )
                    )
            }
            .padding(.horizontal)
        }
        .padding()
        .alert("User Not Found or User Already Added", isPresented: $showUserAlert) {
            Button("OK", role: .cancel) {
                showUserAlert = false
            }
        }
        .alert(isPresented: $showGroupAlert) {
            Alert(
                title: Text(createSuccess ? "Create Group Successful" : "Create Group Error"),
                message: Text(createSuccess ? "Create Group was successful." : "There was an error with creating group."),
                dismissButton: .default(Text("OK")) {
                    dismiss()
                }
            )
        }
    }
    private func createGroup() {
        let userID = viewModel.localUser.id
        users.append(userID)
        DataModel.createGroup(groupName: name, image: imgStr, users: users, creatorID: userID){ success in
            createSuccess = success
            showGroupAlert = true
            
        }
        
    }
    private func searchUser() {
        guard !searchUserID.isEmpty else { return }
        guard let userID = Int(searchUserID) else { return }
        
        isSearching = true
        
        DataModel.getUser(id: userID) { result in
            DispatchQueue.main.async {
                isSearching = false
                
                switch result {
                case .success(let user):
                    // Check if user is already added
                    if users.contains(where: { $0 == user.id }) {
                        showUserAlert = true
                        searchUserID = ""
                    } else {
                        users.append(user.id)
                        displayUsers.append(user)
                        searchUserID = ""
                    }
                case .failure:
                    showUserAlert = true
                    searchUserID = ""
                }
            }
        }
    }
}
