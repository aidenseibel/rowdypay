//
//  GroupsDetail.swift
//  rowdypay
//
//  Created by Khoi Tran on 10/26/24.
//

import SwiftUI

struct GroupsDetail: View {
    @EnvironmentObject var viewModel: ViewModel
    let thisgroup: Group
    @State private var users: [User] = []
    @State private var isLoading: Bool = true
    @State private var errorMessage: String? // Optional error message
    @State private var amount: Double = 2
    
    @State private var payments: [Payment] = []
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 20){
                ScrollView(.horizontal){
                    HStack {
                        if isLoading {
                            // Loading indicator
                            ProgressView("Loading users...")
                        } else if let errorMessage = errorMessage {
                            // Show error message
                            Text("Error: \(errorMessage)")
                                .foregroundColor(.red)
                        } else if users.isEmpty {
                            // No users found
                            Text("No users in this group.")
                                .foregroundStyle(.gray)
                        } else {
                            // Show first 4 users
                            ForEach(users.prefix(4), id: \.self) { user in
                                VStack {
                                    AsyncImage(url: URL(string: user.image)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: screenWidth * 0.20, height: screenWidth * 0.20)
                                            .clipShape(Circle())
                                    } placeholder: {
                                        Circle()
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: screenWidth * 0.20, height: screenWidth * 0.20)
                                    }
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
                                    Text("More")
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }
                
                
                if amount > 0 {
                    NavigationLink {
                        MakePayment(mygroup: thisgroup, amount: amount)
                    } label: {
                        HStack{
                            Image(systemName: "exclamationmark.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.accentColor)
                                .frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading){
                                Text("You owe ")
                                    .font(.system(size: 16))
                                +
                                Text("$\(amount, specifier: "%.2f")")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                +
                                Text(" to \(thisgroup.name)")
                                    .font(.system(size: 16))

                                
                                Text("Tap to make a payment to this group")
                                    .font(.system(size: 12))

                            }
                            Spacer()
                        }
                        .padding()
                        .background(.darkGray)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))

                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                VStack(alignment: .leading, spacing: 10){
                    Text("Group history")
                        .font(.system(size: 22))
                        .bold()
                    
                    if payments.isEmpty{
                        Text("No payments have been made yet.")
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                    }else{
                        ForEach(payments, id: \.self){ payment in
                            PaymentSubView(payment: payment, showsUser: true)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle(thisgroup.name)
            .onAppear {
                fetchUsers()
                fetchBalance(groupID: thisgroup.id)
                fetchPayments()
            }
            .refreshable {
                fetchPayments()
            }
        }
    }
        
    private func fetchUsers() {
        let listofuserIDs = thisgroup.users
        let dispatchGroup = DispatchGroup()
        
        var fetchedUsers = [User]()
        
        for userID in listofuserIDs {
            dispatchGroup.enter()
            DataModel.getUser(id: userID) { result in
                switch result {
                case .success(let user):
                    fetchedUsers.append(user)
                case .failure(let error):
                    print("Failed to fetch user \(userID): \(error)")
                    // Optionally handle the error, maybe show an alert
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.users = fetchedUsers
            self.isLoading = false
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
    
    private func fetchPayments() {
        DataModel.getPaymentsFromGroup(id: thisgroup.id) { fetchedPayments in
            print("fetchedPayments...")

            DispatchQueue.main.async {
                if fetchedPayments.isEmpty {
                    self.payments = []
                    self.errorMessage = nil
                } else {
                    self.payments = fetchedPayments
                    print("fetchedPayments")
                    print(fetchedPayments)
                    self.errorMessage = nil
                }
                self.isLoading = false
            }
        }
    }
}



