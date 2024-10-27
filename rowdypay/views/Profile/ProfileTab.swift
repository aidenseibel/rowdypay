//
//  ProfileTab.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI
import Shimmer

struct ProfileTab: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var payments: [Payment] = []
    @State private var isLoading: Bool = true
    @State private var errorMessage: String? // Optional error message
    let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 50) {
                
                    // MARK: AVATAR
                    HStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 20) {
                            ZStack{
                                Image(viewModel.localUser.image)
                                    .resizable()
                                    .frame(width: screenWidth * 0.70, height: screenWidth * 0.70)
                                    .cornerRadius(screenWidth * 0.35)
                                    .padding()
                                    .overlay(
                                        Circle()
                                            .stroke(Color.gray, lineWidth: 1)
                                    )

                                Circle()
                                    .frame(width: screenWidth * 0.70, height: screenWidth * 0.70)
                                    .cornerRadius(screenWidth * 0.35)
                                    .padding()
                                    .opacity(0.10)
                                    .shimmering()
                            }
                            
                            VStack(alignment: .center, spacing: 7) {
                                Text(viewModel.localUser.username) // Assuming 'username' is a property in localUser
                                    .font(.system(size: 36))
                                    .bold()
                                Text(viewModel.localUser.email) // Assuming 'email' is a property in localUser
                                    .font(.system(size: 16))
                                Text("Joined on "+formatDateToCustomString(date: viewModel.localUser.dateJoined))
                                    .font(.system(size: 12))
                            }
                        }
                        Spacer()
                    }
                    
                    // MARK: RECENT PAYMENTS
                    VStack(alignment: .leading, spacing: 15) {
                        Text("My statistics")
                            .font(.system(size: 24))
                            .bold()
                        
                        HStack(alignment: .center, spacing: 10){
                                Image("a")
                                .resizable()
                                .frame(width: screenWidth * 0.25, height: screenWidth * 0.25)
                                .scaledToFill()
                                .cornerRadius(10)
                            
                                VStack(alignment: .leading, spacing: 7){
                                    Text("Your Reliability: ") + Text("Stellar")
                                        .font(.system(size: 18))
                                        .bold()
                                    Text("You've been making regular payments and keeping up with your groups. Good job!")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.gray)
                                }

                            Spacer()
                        }
                        .padding(8)
                        .background(Color(.darkerGray))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                    }
                    
                    // MARK: RECENT PAYMENTS
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Recent Payments")
                            .font(.system(size: 24))
                            .bold()
                        
                        if isLoading {
                            HStack{
                                Spacer()
                                ProgressView("Loading payments...")
                                Spacer()
                            }
                            .padding(20)
                            
                        } else if let errorMessage = errorMessage {
                            // Show error message
                            Text("Error: \(errorMessage)")
                                .foregroundColor(.red)
                        } else if payments.isEmpty {
                            // No payments found
                            Text("You have not made any payments yet.")
                                .foregroundStyle(.gray)
                        } else {
                            // Display payments
                            ForEach(payments, id: \.self) { payment in
                                PaymentSubView(payment: payment)
                            }
                        }
                    }
                }
                .padding(10)
                .onAppear {
                    fetchPayments()
                }
            }
            .navigationTitle("my profile")
            .refreshable {
                isLoading = true
                fetchPayments()
            }
        }
    }

    
    private func fetchPayments() {
        let userId = viewModel.localUser.id
        
        DataModel.getPaymentsFromUser(id: userId) { fetchedPayments in
            DispatchQueue.main.async {
                if fetchedPayments.isEmpty {
                    self.payments = []
                    self.errorMessage = nil
                } else {
                    self.payments = fetchedPayments
                    self.errorMessage = nil
                }
                self.isLoading = false
            }
        }
    }
}

#Preview {
    ProfileTab()
}
