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
            GeometryReader { geometry in
                if isLoading{
                    ProgressView("Loading Groups...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // to center it

                }else{
                    List {
                        ForEach(groups) { group in
                            NavigationLink {
                                GroupsDetail(thisgroup: group)
                            } label: {
                                GroupSubView(group: group)
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Groups")
        }
        .onAppear {
            fetchGroups()  // Fetch when view appears
        }
        .refreshable {
            fetchGroups()  // Allow pull-to-refresh
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
