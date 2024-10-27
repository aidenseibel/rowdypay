//
//  GroupSubView.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI
import Shimmer

struct GroupSubView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var group: Group
    var screenWidth = UIScreen.main.bounds.width
    
    @State var numUsers: Int = 0
    @State var users: [User] = []
    @State private var amount: Double = 2.0
    var body: some View {
        HStack {
            if let url = URL(string: group.image), UIApplication.shared.canOpenURL(url) {
                // If it's a URL, load asynchronously
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // Shows loading indicator
                            .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
                            .cornerRadius(10)
                    case .failure:
                        Image(systemName: "photo") // Placeholder for failed load
                            .resizable()
                            .scaledToFill()
                            .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
                            .cornerRadius(10)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                // Otherwise, assume it's a local asset
                Image(group.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(group.name)
                    .font(.system(size: 22))
                    .lineLimit(1)
                    .bold()
                Text("\(group.users.count) members")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                HStack{
                    ForEach(users.prefix(3), id: \.self){ user in
                        AsyncImage(url: URL(string: user.image)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .cornerRadius(15)
                        } placeholder: {
                            RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 30, height: 30)
                        }
                    }
                    
                    if(numUsers) > 3{
                        Text("+\(numUsers - 3)")
                            .font(.system(size: 14))
                        
                    }
                }
                Text("Amount Owed: ")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                +
                Text("$\(amount, specifier: "%.2f")")
                    .bold()
                    .font(.system(size: 14))
                    .foregroundColor(.gray)

            }
            .padding(.leading, 8)

            Spacer()
        }
        .padding(10)
        .background(Color(.darkerGray))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
        .onAppear {
            fetchUsers()
            fetchBalance(groupID:group.id)
        }
    }
    
    func fetchUsers() {
        DataModel.getUsersFromGroup(id: group.id) { users in
            self.users = users
            self.numUsers = users.count
        }
    }
    private func fetchBalance(groupID: Int) {
        let groupID = groupID
        let userID = viewModel.localUser.id
        DataModel.getBalances(userID: userID, groupID: groupID) { result in
            switch result {
            case .success(let balance):
                self.amount = balance
            case .failure(let error):
                print("Error fetching balance: \(error)")
            }
        }
    }

}

#Preview {
    GroupSubView(group: Group())
}
