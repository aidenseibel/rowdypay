//
//  ConfirmAddFromReceiptView.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

struct ConfirmAddFromReceiptView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var navigationPath: NavigationPath

    var price: Double
    @State var selectedGroup: Group?
    @State private var showSuccessAlert = false // State variable for controlling the alert

    var screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("confirm amount")
                .padding(.top, 50)
            
            HStack(alignment: .center, spacing: 1) {
                Spacer()
                Text("$")
                    .font(.system(size: 24))
                    .bold()
                Text(String(format: "%.2f", price))
                    .font(.system(size: 60))
                    .bold()
                Spacer()
            }
            
            NavigationLink {
                SelectGroupView(selectedGroup: $selectedGroup) // Pass the binding here
            } label: {
                Text(selectedGroup?.name ?? "Select a group") // Show selected group's name if exists
            }

            Spacer()
            
            Button {
                if let group = selectedGroup {
                    let userID = viewModel.localUser.id
                    let allOtherUsers = group.users

                    DataModel.updateBalances(userID: userID, userIDs: allOtherUsers, groupID: group.id, amount: price) { success in
                        
                        if success {
                            DispatchQueue.main.async {
                                showSuccessAlert = true // Show alert on success
                            }
                        }
                    }
                }
            } label: {
                HStack {
                    Spacer()
                    Text("Submit")
                    Spacer()
                }
                .padding()
                .foregroundColor(.white)
                .background(.orange)
                .cornerRadius(10)
                .padding()
            }
        }
        .padding(10)
        .navigationTitle("Confirm request")
        .alert(isPresented: $showSuccessAlert) { // Alert modifier
            Alert(title: Text("Success"), message: Text("The transaction was successful."), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    ConfirmAddFromReceiptView(navigationPath: .constant(NavigationPath()), price: 10.0)
}
