//
//  Payment.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import Foundation

class Payment: Identifiable, Codable {
    var id: UUID = UUID()
    var user: UUID
    var group: UUID
    var amount: Double
}
