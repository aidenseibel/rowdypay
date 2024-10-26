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
        Group(id: 1, name: "Test Group", image: "beautiful", users: [])
    ]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                List {
                    ForEach(groups) { group in
                        GroupSubView(group: group)
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
