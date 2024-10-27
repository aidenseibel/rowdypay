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
    @State private var sortOption = SortOption.none
    @State private var groupAmounts: [Int: Double] = [:]
    
    enum SortOption {
        case none
        case amountHighToLow
        case amountLowToHigh
    }
    var sortedGroups: [Group] {
        switch sortOption {
        case .none:
            return groups
        case .amountHighToLow:
            return groups.sorted {
                groupAmounts[$0.id] ?? 0 > groupAmounts[$1.id] ?? 0
            }
        case .amountLowToHigh:
            return groups.sorted {
                groupAmounts[$0.id] ?? 0 < groupAmounts[$1.id] ?? 0
            }
        }
    }
    var body: some View {
        NavigationStack {
        
            ZStack {
                SharedViews.motionAnimator
                    .ignoresSafeArea()
                ScrollView{

                VStack{
                    HStack{
                        Menu {
                            Button("Default") {
                                sortOption = .none
                            }
                            Button("Highest Amount") {
                                sortOption = .amountHighToLow
                            }
                            Button("Lowest Amount") {
                                sortOption = .amountLowToHigh
                            }
                        } label: {
                            HStack {
                                Text(sortOption == .none ? "Default" :
                                        sortOption == .amountHighToLow ? "Highest Amount" : "Lowest Amount")
                                Image(systemName: "chevron.down")
                            }
                            .foregroundColor(.primary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(.systemGray6))
                            )
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                   
                    if isLoading {
                        ProgressView("Loading Groups...")
                    } else {
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(sortedGroups) { group in
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
                                .background(.clear)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                        }
                        .padding(10)
                        .padding(.bottom, 50)
                    }
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
                fetchAllBalances(for: fetchedGroups)

            }
        }
    }
    private func fetchAllBalances(for groups: [Group]) {
        let userID = viewModel.localUser.id
        let dispatchGroup = DispatchGroup()
        
        for group in groups {
            dispatchGroup.enter()
            DataModel.getBalances(userID: userID, groupID: group.id) { result in
                switch result {
                case .success(let balance):
                    DispatchQueue.main.async {
                        self.groupAmounts[group.id] = balance
                    }
                case .failure(let error):
                    print("Error fetching balance for group \(group.id): \(error)")
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.isLoading = false
        }
    }
    
}
#Preview {
    GroupsTab()
}
