//
//  Group.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import Foundation

class Group: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var image: String
    var users: [UUID]

    init(id: UUID = UUID(), name: String, image: String, users: [UUID]) {
        self.id = id
        self.name = name
        self.image = image
        self.users = users
    }
}

