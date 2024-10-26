//
//  GroupsDetail.swift
//  rowdypay
//
//  Created by Khoi Tran on 10/26/24.
//

import SwiftUI

struct GroupsDetail: View {
    let thisgroup: Group
    
    @State private var users: [User] = []
    @State private var isLoading: Bool = true
    @State private var errorMessage: String? // Optional error message

    var body: some View {
        VStack{
            Text(thisgroup.name)
            
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
                    ForEach(users, id: \.self) { user in
                        VStack {
                            Image(user.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                            Text(user.username)
                                .font(.caption)
                        }
                    }
                }
                
//                // If there are more than 4 users, show the remaining count
//                if thisgroup.users.count > 4 {
//                    VStack {
//                        ZStack {
//                            Circle()
//                                .fill(Color.gray.opacity(0.2))
//                                .frame(width: 40, height: 40)
//                            Text("+\(thisgroup.users.count - 4)")
//                                .font(.caption)
//                                .foregroundColor(.gray)
//                        }
//                        Text("More")
//                            .font(.caption)
//                    }
//                }
            }
            Text("You Owe")
            
        }
    }
    
    private func fetchUsers() {
        let groupID = thisgroup.id
        
        DataModel.getUsersFromGroup(id: groupID){ users in
            DispatchQueue.main.async {
                if users.isEmpty {
                    self.users = []
                    self.errorMessage = nil
                } else {
                    self.users = users
                    self.errorMessage = nil
                }
                self.isLoading = false
            }
        }
    }
}

