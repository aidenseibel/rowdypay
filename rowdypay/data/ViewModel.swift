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
        self.localUser = User()

        if let email = UserDefaults.standard.string(forKey: "email"){
            DataModel.authUser(email: email) { user in
                DispatchQueue.main.async {
                    print("changing local user")
                    self.localUser = user
                    self.hasOnboarded = true
                }
            }
        } else {
            self.localUser = User()
            self.hasOnboarded = false
        }
    }
}
