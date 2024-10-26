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
}

var sample_groups = [Group(), Group(), Group()]
