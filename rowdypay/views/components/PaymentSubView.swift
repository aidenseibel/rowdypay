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
            if let group = group {
                AsyncImage(url: URL(string: group.image)) { image in
                    image
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                } placeholder: {
                    RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                        .frame(width: 50, height: 50)
                }
                
                VStack(alignment: .leading, spacing: 7){
                    Text("$" + String(format: "%.2f", payment.amount) + " to \(group.name)")
                        .lineLimit(1)
                        .font(.system(size: 16))
                    HStack {
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
                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                    .frame(width: UIScreen.main.bounds.width * 0.90, height: 70)
            }

            Spacer()
        }
        .padding(8)
        .background(Color(.darkerGray))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
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
