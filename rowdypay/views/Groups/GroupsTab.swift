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
    @EnvironmentObject var viewModel: ViewModel
    @State private var groups: [Group] = []
    @State private var isLoading = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                if isLoading {
                    ProgressView("Loading Groups...")
                } else {
                    VStack(spacing: 0) {
                        List {
                            ForEach(groups) { group in
                                NavigationLink {
                                    GroupsDetail(thisgroup: group)
                                } label: {
                                    GroupSubView(group: group)
                                }
                            }
                        }
                        
                        // Create Group button at bottom
                        NavigationLink {
                            CreateGroup()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Create Groups")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                                    .foregroundColor(.accent)
                                Image(systemName: "plus.circle")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                                    .foregroundColor(.accent)
                            }
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color(UIColor.systemBackground))
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                    }
                }
            }
            .navigationTitle("My Groups")
        }
        .onAppear {
            fetchGroups()
        }
        .refreshable {
            fetchGroups()
        }
    }
    
    private func fetchGroups() {
        let userID = viewModel.localUser.id
        isLoading = true
        DataModel.getGroupsFromUser(id: userID) { fetchedGroups in
            DispatchQueue.main.async {
                self.isLoading = false
                self.groups = fetchedGroups
            }
        }
    }
}
#Preview {
    GroupsTab()
}
