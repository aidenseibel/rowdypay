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
    var image: String
    var groups: [UUID]
}
