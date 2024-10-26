//
//  ProfileTab.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

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
                            Image(viewModel.localUser.image)
                                .resizable()
                                .frame(width: screenWidth * 0.70, height: screenWidth * 0.70)
                                .cornerRadius(screenWidth * 0.35)
                                .padding()
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 1)
                                )
                            
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
                        Text("Recent Payments")
                            .font(.system(size: 24))
                            .bold()
                        
                        if isLoading {
                            // Loading indicator
                            ProgressView("Loading payments...")
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
