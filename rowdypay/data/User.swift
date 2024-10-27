//
//  User.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import Foundation

class User: Identifiable, Hashable, Codable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: Int
    var username: String
    var email: String
    var image: String
    var groups: [Int]
    var payments: [Int]
    var dateJoined: Date
    
    // for json decoding
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case username = "display_name"
        case email = "email"
        case image = "img"
        case groups = "groups"
        case payments = "payments"
        case dateJoined = "date_created"
    }

    // for decoding dates
    enum DateCodingKeys: String, CodingKey {
        case day
        case month
        case year
    }
    
    init() {
        self.id = 1
        self.username = "user_1"
        self.email = "user@gmail.com"
        self.image = "car"
        self.groups = []
        self.payments = []
        self.dateJoined = Date()
    }
    
    // from json
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.username = try container.decode(String.self, forKey: .username)
        self.email = try container.decode(String.self, forKey: .email)
        self.image = try container.decode(String.self, forKey: .image)
        self.groups = try container.decode([Int].self, forKey: .groups)
        self.payments = try container.decode([Int].self, forKey: .payments)

        
        // Handle timestamp as Int
        let timestamp = try container.decode(Int.self, forKey: .dateJoined)
        dateJoined = Date(timeIntervalSince1970: TimeInterval(timestamp))
    }
}
