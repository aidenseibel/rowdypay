//
//  ViewModel.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import Foundation

public class ViewModel: ObservableObject {
    @Published var localUser: User
    @Published var isTabBarShowing: Bool = true
    @Published var hasOnboarded: Bool = false
    
    init() {
        localUser = User()
    }
}
