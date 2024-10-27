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
        case date = "date_created"
    }

    // for decoding dates
    enum DateCodingKeys: String, CodingKey {
        case day
        case month
        case year
    }

    // randomized
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

        let utc_timestamp = try container.decode(Int.self, forKey: .date)
        self.date = Date(timeIntervalSince1970: TimeInterval(utc_timestamp))
    }
}
