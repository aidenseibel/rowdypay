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
    
    var id: Int
    var user: Int
    var group: Int
    var description: String
    var amount: Double
    var date: Date
    
    // for json decoding
    enum CodingKeys: String, CodingKey {
        case id = "pmt_id"
        case user = "user_id"
        case group = "group_id"
        case description = "description"
        case amount = "amt"
        case date = "date_made"
    }

    enum DateCodingKeys: String, CodingKey {
        case day
        case month
        case year
    }

    // randomize
    init() {
        self.id = Int.random(in: 1...10000)
        self.user = 1
        self.group = 1
        self.description = "for the hackathon!"
        self.amount = Double.random(in: 10.0...50.0)
        self.date = Date()
    }
    
    // from json
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.user = try container.decode(Int.self, forKey: .user)
        self.group = try container.decode(Int.self, forKey: .group)
        self.description = try container.decode(String.self, forKey: .description)
        self.amount = try container.decode(Double.self, forKey: .amount)

        
        // Decode the date from the nested JSON object
        let dateContainer = try container.nestedContainer(keyedBy: DateCodingKeys.self, forKey: .date)
        let day = try dateContainer.decode(Int.self, forKey: .day)
        let month = try dateContainer.decode(Int.self, forKey: .month)
        let year = try dateContainer.decode(Int.self, forKey: .year)
        
        // Create a Date from the components
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        
        let calendar = Calendar.current
        self.date = calendar.date(from: dateComponents) ?? Date() // Fallback to current date if decoding fails
    }
}


var sample_payments = [
    Payment(), Payment(), Payment()
]
