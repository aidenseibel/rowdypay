//
//  rowdypayApp.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

@main
struct rowdypayApp: App {
    var body: some Scene {
        WindowGroup {
            TabView() {
                BudgetTab()
                    .tabItem {
                        Label("Groups", systemImage: "square.stack.fill")
                    }

                AddTab()
                    .tabItem {
                        Label("Add", systemImage: "plus.circle.fill")
                    }

                ProfileTab()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle.fill")
                    }
            }
            .onAppear {
                DataModel.getHelloWorld()
            }
        }
    }
}
