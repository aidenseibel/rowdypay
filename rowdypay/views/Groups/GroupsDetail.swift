//
//  GroupsDetail.swift
//  rowdypay
//
//  Created by Khoi Tran on 10/26/24.
//

import SwiftUI

struct GroupsDetail: View {
    let thisgroup: Group
    var body: some View {
        VStack{
            Text(thisgroup.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Spacer()
            HStack {
                // Show first 4 users
                ForEach(Array(thisgroup.users.prefix(4)), id: \.self) { userID in
                    let user = DataModel.getUser(id: userID)
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
                        Text("\(thisgroup.users.count - 4) More")
                            .font(.caption)
                    }
                }
            }
            Text("You Owe")
            Text("$20")
            
        }
    }
}


