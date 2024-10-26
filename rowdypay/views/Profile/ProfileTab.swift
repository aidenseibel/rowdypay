//
//  ProfileTab.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

struct ProfileTab: View {
    @EnvironmentObject var viewModel: ViewModel
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 50) {
                
                    // MARK: AVATAR
                    HStack{
                        Spacer()
                        VStack(alignment: .center, spacing: 20){
                            Image("pfp")
                                .resizable()
                                .frame(width: screenWidth * 0.70, height: screenWidth * 0.70)
                                .cornerRadius(screenWidth * 0.35)
                                .padding()
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 1)
                                )
                            
                            VStack(alignment: .center, spacing: 7){
                                Text("aseibel")
                                    .font(.system(size: 36))
                                    .bold()
                                Text("aseibel@trinity.edu")
                                    .font(.system(size: 16))
                                Text("joined october 26th, 2024")
                                    .font(.system(size: 12))
                            }
                        }
                        Spacer()
                    }
                    
                    // MARK: RECENT PAYMENTS
                    VStack(alignment: .leading, spacing: 15){
                        Text("recent payments")
                            .font(.system(size: 24))
                            .bold()
                        
                        if viewModel.localUser.getPayments().isEmpty {
                            Text("You have not made any payments yet.")
                                .foregroundStyle(.gray)
                        } else {
                            ForEach(viewModel.localUser.getPayments(), id: \.self){ payment in
                                PaymentSubView(payment: payment)
                            }
                        }
                    }
                }
                .padding(10)
            }
        }
    }
}

#Preview {
    ProfileTab()
}
