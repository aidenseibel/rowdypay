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
    @State private var openChangeAvatar: Bool = false
    
    let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 25){
                VStack(alignment: .leading, spacing: 10) {
                    Text("Add Group Image")
                        .font(.system(size: 24))
                        .bold()
                    
                    Button {
                        openChangeAvatar = true
                    } label: {
                        HStack{
                            Spacer()
                            ZStack {
                                RoundedRectangle(cornerRadius: screenWidth * 0.25)
                                    .fill(Color(.darkerGray))
                                    .frame(width: screenWidth * 0.50, height: screenWidth * 0.50)
                                
                                if imgStr == "" {
                                    Text("Tap to Select an Image")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                } else {
                                    Image(imgStr)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: screenWidth * 0.50, height: screenWidth * 0.50)
                                        .clipShape(RoundedRectangle(cornerRadius: screenWidth * 0.25))
                                }
                            }
                            Spacer()
                        }
                    }

                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Add Group Name")
                        .font(.system(size: 24))
                        .bold()
                    
                    TextField("Enter Group Name", text: $name)
                        .font(.system(size: 16))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemGray6))
                        )
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Add Users")
                        .font(.system(size: 24))
                        .bold()
                    
                    HStack {
                        TextField("Enter User ID", text: $searchUserID)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.systemGray6))
                            )
                        
                        Button {
                            searchUser()
                        } label: {
                            Text("Add User")
                                .foregroundColor(.accent)
                        }
                        .disabled(searchUserID.isEmpty || isSearching)


                    }
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
                }
                
                Button(action: {
                    createGroup()
                }) {
                    HStack {
                        Spacer()
                        Text("Create Group")
                        Spacer()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(.orange)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .onAppear{
            viewModel.isTabBarShowing = false
        }
        .onTapGesture {
            self.endTextEditing()
        }
        .navigationTitle("Create New Group")
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
        .sheet(isPresented: $openChangeAvatar) {
            ChangeGroupAvatarView(selectedImage: $imgStr)
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

extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}

