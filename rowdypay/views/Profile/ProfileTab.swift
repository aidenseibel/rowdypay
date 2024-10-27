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
    @ObservedObject var reloadViewHelper = ReloadViewHelper()

    @State private var payments: [Payment] = []
    @State private var isLoading: Bool = true
    @State private var errorMessage: String? // Optional error message
    let screenWidth = UIScreen.main.bounds.width
    
    @State var openChangeAvatar: Bool = false
    
    @State var userAvatar: String = "car"

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 50) {
                
                    // MARK: AVATAR
                    HStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 20) {
                            Button {
                                openChangeAvatar = true
                            } label: {
                                ZStack{
                                    Circle()
                                        .frame(width: screenWidth * 0.50, height: screenWidth * 0.50)
                                        .cornerRadius(screenWidth * 0.35)
                                        .opacity(0.05)
                                        .padding()

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
                            }
                            .buttonStyle(.plain)
                            
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
                        
                        NavigationLink {
                            ReliabilityReportView()
                        } label: {
                            HStack(alignment: .center, spacing: 10){
                                    Image("a")
                                    .resizable()
                                    .frame(width: screenWidth * 0.25, height: screenWidth * 0.25)
                                    .scaledToFill()
                                    .cornerRadius(10)
                                
                                    VStack(alignment: .leading, spacing: 5){
                                        Text("Your Reliability: ") + Text("Stellar")
                                            .font(.system(size: 18))
                                            .bold()
                                        Text("Click here to check out your reliability report!")
                                            .font(.system(size: 12))
                                            .foregroundStyle(.gray)
                                    }
                                Spacer()
                            }
                            .padding(8)
                            .background(Color(.darkerGray))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                        }
                        .buttonStyle(.plain)

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
                .padding(.bottom, 50)
                .onAppear {
                    fetchPayments()
                }
            }
            .navigationTitle("My profile")
            .refreshable {
                isLoading = true
                fetchPayments()
            }
            .navigationBarItems(trailing:
                NavigationLink(destination: {
                    SettingsView()
                }, label: {
                    Image(systemName: "gear")}
                )
            )
            .sheet(isPresented: $openChangeAvatar, onDismiss: {
                openChangeAvatar = false
            }, content: {
                ChangeAvatarView()
                    .onDisappear{
                        reloadViewHelper.reloadView()
                    }
            })
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
