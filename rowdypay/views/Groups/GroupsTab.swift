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
                    ScrollView{
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(groups) { group in
                                NavigationLink {
                                    GroupsDetail(thisgroup: group)
                                } label: {
                                    GroupSubView(group: group)
                                }
                                .buttonStyle(.plain)
                            }
                            
                            NavigationLink {
                                CreateGroup()
                            } label: {
                                HStack {
                                    Image(systemName: "plus.circle")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                        .foregroundColor(.accent)

                                    Text("Create a Group")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                        .foregroundColor(.accent)
                                }
                                .background(Color(UIColor.systemBackground))
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                        }
                        .padding(10)
                        .padding(.bottom, 50)
                    }
                }
            }
            .navigationTitle("My Groups")
        }
        .onAppear {
            fetchGroups()
            viewModel.isTabBarShowing = true
        }
        .refreshable {
            fetchGroups()
            viewModel.isTabBarShowing = true
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
