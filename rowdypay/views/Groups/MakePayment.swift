//
//  MakePayment.swift
//  rowdypay
//
//  Created by Khoi Tran on 10/26/24.
//

import SwiftUI

struct MakePayment: View {
    @Environment(\.dismiss) var dismiss
    let mygroup: Group
    let amount: Double
    @EnvironmentObject var viewModel: ViewModel
    @State private var description: String = ""
    @State private var showAlert: Bool = false
    @State private var paymentSuccess: Bool = false

    var body: some View {
        ZStack{
            DotsCircleView()
                .ignoresSafeArea()
            VStack(spacing: 16) {
                Text("You owe: $\(amount, specifier: "%.2f")")
                    .font(.title)
                    .fontWeight(.bold)

                
                TextField("Payment Description (Optional)", text: $description)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemGray6))
                    )
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                    .padding(.horizontal)

                Button(action: {
                    makePayment()
                }) {
                    Text("Make Payment")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.accent)
                                .shadow(
                                    color: Color.accent.opacity(0.3),
                                    radius: 8,
                                    x: 0,
                                    y: 4
                                )
                        )
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(paymentSuccess ? "Payment Successful" : "Payment Error"),
                message: Text(paymentSuccess ? "Your payment was successful." : "There was an error with your payment."),
                dismissButton: .default(Text("OK")) {
                    dismiss()
                }
            )
        }
        .onAppear(){
            viewModel.isTabBarShowing = false
        }
        
        
    }

    private func makePayment() {
        let userID = viewModel.localUser.id
        let groupID = mygroup.id

        DataModel.makePayment(userID: userID, groupID: groupID, amount: amount, description: description.prefix(200).description) { success in
            paymentSuccess = success
            showAlert = true
        }
    }
}
