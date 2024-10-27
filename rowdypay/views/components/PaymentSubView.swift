//
//  PaymentSubView.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

struct PaymentSubView: View {
    var payment: Payment
    @State private var group: Group?
    
    init(payment: Payment) {
        self.payment = payment
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 10){
            if let group = group{
                Image(group.image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 1))
                
                
                VStack(alignment: .leading, spacing: 7){
                    Text("$" + String(format: "%.2f", payment.amount)+" to \(group.name)")
                        .lineLimit(1)
                        .font(.system(size: 16))
                    HStack{
                        Text(formatDateToCustomString(date: payment.date))
                            .font(.system(size: 12))
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 4, height: 4)
                        Text(payment.description)
                            .font(.system(size: 12))
                    }
                }
            } else {
                // Placeholder while loading
                ProgressView("Loading...")
                    .frame(width: 50, height: 50)
            }
            Spacer()
        }

        .padding(8)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 1))
        .onAppear {
            DataModel.getGroup(id: payment.group) { fetchedGroup in
                self.group = fetchedGroup
            }
        }
    }
}

#Preview {
    PaymentSubView(payment: Payment())
}
