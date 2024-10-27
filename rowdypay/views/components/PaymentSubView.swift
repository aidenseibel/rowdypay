//
//  PaymentSubView.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

struct PaymentSubView: View {
    var payment: Payment
    var showsUser: Bool

    @State private var group: Group?
    @State private var user: User?
    
    init(payment: Payment) {
        self.payment = payment
        self.showsUser = false
    }
    
    init(payment: Payment, showsUser: Bool) {
        self.payment = payment
        self.showsUser = showsUser
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 10){
            if let group = group {
                if let url = URL(string: group.image), UIApplication.shared.canOpenURL(url) {
                    // If it's a URL, load asynchronously
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
                                .frame(width: 50, height: 50)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                        case .failure:
                            Image(systemName: "photo") // Placeholder for failed load
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    // Otherwise, assume it's a local asset
                    Image(group.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .cornerRadius(5)
                }
                
                VStack(alignment: .leading, spacing: 7){
                    if showsUser{
                        if let user = user{
                            Text("$" + String(format: "%.2f", payment.amount) + " from \(user.username)")
                                .lineLimit(1)
                                .font(.system(size: 16))
                        }
                    } else {
                        Text("$" + String(format: "%.2f", payment.amount) + " to \(group.name)")
                            .lineLimit(1)
                            .font(.system(size: 16))
                    }
                              
                    HStack {
                        Text(formatDateToCustomString(date: payment.date))
                            .font(.system(size: 12))
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 4, height: 4)
                        Text(payment.description)
                            .font(.system(size: 12))
                            .lineLimit(1)
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
            fetchGroup()
            fetchUser()
        }
    }
    
    func fetchGroup(){
        DataModel.getGroup(id: payment.group) { fetchedGroup in
            self.group = fetchedGroup
        }

    }
    
    func fetchUser() {
        DataModel.getUser(id: payment.user) { result in
            switch result {
            case .success(let fetchedUser):
                self.user = fetchedUser
            case .failure(let error):
                // Handle the error appropriately, e.g., log it or show an alert
                print("Failed to fetch user: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    PaymentSubView(payment: Payment())
}
