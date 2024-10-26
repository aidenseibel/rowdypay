//
//  User.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import Foundation

class User: Identifiable, Codable, ObservableObject {
    var id: Int
    var username: String
    var email: String
    var image: String
    var groups: [Int]
    var payments: [Int]
    var dateJoined: Date
    
    init() {
        self.id = 1
        self.username = "user_1"
        self.email = "user@gmail.com"
        self.image = "sample_profile_image"
        self.groups = []
        self.payments = []
        self.dateJoined = Date()
    }
    
    func getPayments(completion: @escaping ([Payment]) -> Void) {
        DataModel.getPaymentsFromUser(id: self.id) { payments in
            completion(payments)
        }
    }
}
