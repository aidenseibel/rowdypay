//
//  SettingsView.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var showSignOutAlert = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Text("Account")
                    .font(.system(size: 24))
                    .bold()
                Button {
                    showSignOutAlert = true
                } label: {
                    Text("Sign Out")
                }
                .padding()
                .alert(isPresented: $showSignOutAlert) {
                    Alert(
                        title: Text("Confirm Sign Out"),
                        message: Text("Are you sure you want to sign out?"),
                        primaryButton: .destructive(Text("Yes")) {
                            viewModel.hasOnboarded = false
                        },
                        secondaryButton: .cancel()
                    )
                }
                HStack{
                    Spacer()
                }
            }
            .padding()
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
