//
//  GroupsDetail.swift
//  rowdypay
//
//  Created by Khoi Tran on 10/26/24.
//

import SwiftUI

struct GroupsDetail: View {
    @EnvironmentObject var viewModel: ViewModel
    let thisgroup: Group
    @State private var users: [User] = []
    @State private var isLoading: Bool = true
    @State private var errorMessage: String? // Optional error message
    
    var body: some View {
        VStack(spacing: 16){
                HStack {
                    if isLoading {
                        // Loading indicator
                        ProgressView("Loading users...")
                    } else if let errorMessage = errorMessage {
                        // Show error message
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                    } else if users.isEmpty {
                        // No users found
                        Text("No users in this group.")
                            .foregroundStyle(.gray)
                    } else {
                        // Show first 4 users
                        ForEach(users.prefix(4), id: \.self) { user in
                            VStack {
                                AsyncImage(url: URL(string: user.image)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Circle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 40, height: 40)
                                }
                                Text(user.username)
                                    .font(.caption)
                            }
                        }
                        // If there are more than 4 users, show the remaining count
                        if thisgroup.users.count > 4 {
                            VStack {
                                ZStack {
                                    Circle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 40, height: 40)
                                    Text("+\(thisgroup.users.count - 4)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Text("More")
                                    .font(.caption)
                            }
                        }
                    }
                }
                Text("\(users.count) users in this group")  // Add this temporarily for debugging

                Text("You Owe:")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                
                Text("$20")
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundColor(.primary)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(
                                color: Color.black.opacity(0.1),
                                radius: 10,
                                x: 0,
                                y: 5
                            )
                    )
            let amount = 20.0
                if amount > 0 {
                    NavigationLink {
                        MakePayment(mygroup: thisgroup, amount: amount)
                    } label: {
                        HStack {
                            Text("Make Payment")
                                .font(.title3)
                                .fontWeight(.bold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
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
                        .padding(.horizontal, 24)
                        .padding(.top, 8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle(thisgroup.name)
        .onAppear {
            fetchUsers()
        }
    }
    
    private func fetchUsers() {
        
        let listofuserIDs = thisgroup.users
        let dispatchGroup = DispatchGroup()

        var fetchedUsers = [User]()

        for userID in listofuserIDs {
            dispatchGroup.enter()
            DataModel.getUser(id: userID) { user in
                fetchedUsers.append(user)
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.users = fetchedUsers
            self.isLoading = false
        }
    }
}
//    private func fetchBalance(){
//        let groupID = thisgroup.id
//        let userID = viewModel.localUser.id
//    }


