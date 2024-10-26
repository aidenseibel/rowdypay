//
//  GroupsTab.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

//  fetch user,  need to fetch all groups from 1 individual user
//  else, use a random user

struct GroupsTab: View {
    @State private var groups: [Group] = [
        Group(id: 101, name: "Test Group", image: "beautiful", users: [1,2,3,4,5,6,7]),
        Group(id: 102, name: "Test Group 2", image: "sample_group_image", users: [1,2,3,4,5,6,7,8, 9])

    ]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                List {
                    ForEach(groups) { group in
                        NavigationLink(destination: GroupsDetail(thisgroup: group)) {
                            HStack {
                                Image(group.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .background(Color.gray.opacity(0.2))
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading, spacing: 8) { // Increased spacing
                                    Text(group.name)
                                        .font(.title3)  // Bigger font
                                        .fontWeight(.semibold)
                                    Text("\(group.users.count) members")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding(.leading, 12)  // Increased padding
                                
                                Spacer()
                            }
                            .padding(.vertical, 12)  // Added vertical padding
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))  // Added spacing between rows
                    }
                }
            }
            .navigationTitle("My Groups")
        }
    }
 }

#Preview {
    GroupsTab()
}
