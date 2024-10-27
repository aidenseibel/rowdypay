//
//  GroupSubView.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

struct GroupSubView: View {
    var group: Group
    var screenWidth = UIScreen.main.bounds.width
    
    @State var users: [User] = []

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: group.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
                    .cornerRadius(10)
            } placeholder: {
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(group.name)
                    .font(.system(size: 22))
                    .bold()
                Text("\(group.users.count) members")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                HStack{
                    ForEach(users, id: \.self){ user in
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
                }
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
        }

    }
    
    func fetchUsers() {
        DataModel.getUsersFromGroup(id: group.id) { users in
            self.users = users
        }
    }

}

#Preview {
    GroupSubView(group: Group())
}
