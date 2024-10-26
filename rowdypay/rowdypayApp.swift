//
//  rowdypayApp.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

@main
struct rowdypayApp: App {
    @StateObject var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            TabView() {
                GroupsTab()
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
            .environmentObject(viewModel)
            .onAppear {
                DataModel.getPaymentsFromUser(id: 1) { payments in
                    print(payments)
                }
            }
        }
    }
}
