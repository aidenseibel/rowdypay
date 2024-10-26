//
//  Util.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import Foundation

func formatDateToCustomString(date: Date) -> String {
    // Create a DateFormatter
    let dateFormatter = DateFormatter()
    
    // Set the desired date format
    dateFormatter.dateFormat = "MMMM d, yyyy"
    
    // Format the date
    let formattedDate = dateFormatter.string(from: date)
    
    // Extract the day to determine the ordinal suffix
    let calendar = Calendar.current
    let day = calendar.component(.day, from: date)
    
    // Determine the ordinal suffix
    let ordinalSuffix: String
    switch day {
    case 11, 12, 13:
        ordinalSuffix = "th"
    default:
        switch day % 10 {
        case 1:
            ordinalSuffix = "st"
        case 2:
            ordinalSuffix = "nd"
        case 3:
            ordinalSuffix = "rd"
        default:
            ordinalSuffix = "th"
        }
    }

    // Combine the formatted date with the ordinal suffix
    let finalFormattedDate = formattedDate.replacingOccurrences(of: "\(day)", with: "\(day)\(ordinalSuffix)")
    
    return finalFormattedDate
}
