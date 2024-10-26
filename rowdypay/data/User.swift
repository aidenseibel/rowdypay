//
//  User.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import Foundation

class User: Identifiable, Codable, ObservableObject {
    var id: UUID = UUID()
    var username: String
    var email: String
    var image: String
    var groups: [UUID]
    var payments: [UUID]
    var dateJoined: Date
    
    init() {
        self.username = "user_1"
        self.email = "user@gmail.com"
        self.image = "profile"
        self.groups = []
        self.payments = []
        self.dateJoined = Date()
    }
    
    func getPayments() -> [Payment]{
        return sample_payments
    }
}
