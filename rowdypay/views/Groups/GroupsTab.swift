//
//  BudgetTab.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

//  fetch user,  need to fetch all groups from 1 individual user
//  else, use a random user

struct BudgetTab: View {
    @State private var groups: [Group] = [
        Group(name: "Test Group", image: "beautiful", users: [UUID()])
    ]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                List {
                    ForEach(groups) { group in
                        HStack {
                            Image(group.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(group.name)
                                    .font(.headline)
                                Text("\(group.users.count) members")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.leading, 8)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("My Groups")
        }
    }
}

#Preview {
    BudgetTab()
}
