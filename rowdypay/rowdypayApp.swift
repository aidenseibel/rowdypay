//
//  rowdypayApp.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

@main
struct rowdypayApp: App {
    @State var selectedTab: Tab = .groups
    @StateObject var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            if !viewModel.hasOnboarded{
                Onboarding()
                    .environmentObject(viewModel)
            } else {
                ZStack {
                    VStack {
                        TabView(selection: $selectedTab) {
                            GroupsTab().tag(Tab.groups)
                            AddTab().tag(Tab.add)
                            ProfileTab().tag(Tab.profile)
                        }.environmentObject(viewModel)
                    }
                    
                    if viewModel.isTabBarShowing {
                        VStack {
                            Spacer()
                            TabBar(selectedTab: $selectedTab)
                        }
                    }
                }
                .environmentObject(viewModel)
            }
        }
    }
}
