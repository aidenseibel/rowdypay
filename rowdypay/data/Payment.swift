//
//  Payment.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import Foundation

class Payment: Identifiable, Hashable, Codable {
    static func == (lhs: Payment, rhs: Payment) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: UUID = UUID()
    var user: UUID
    var group: UUID
    var description: String
    var amount: Double
    var date: Date
    
    init() {
        user = UUID()
        group = UUID()
        description = "for the hackathon!"
        amount = Double.random(in: 10.0...50.0)
        date = Date()
    }
}


var sample_payments = [
    Payment(), Payment(), Payment()
]
