//
//  Group.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import Foundation

class Group: Identifiable, Codable, Hashable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }    
    
    var id: Int
    var name: String
    var image: String
    var users: [Int]
    
    // for json decoding
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
        case users = "users"
    }
    
    // randomized
    init() {
        self.id = 1
        self.name = "RowdyHacks Group"
        self.image = "sample_group_image"
        self.users = []
    }
    
    init(id: Int, name: String, image: String, users: [Int]) {
        self.id = id
        self.name = name
        self.image = image
        self.users = users
    }
    
    // from json
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.users = try container.decode([Int].self, forKey: .users)
    }
}
