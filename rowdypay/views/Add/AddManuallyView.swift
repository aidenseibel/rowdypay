import SwiftUI

struct AddManuallyView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var price: String = ""
    @FocusState private var isTextFieldFocused: Bool // Control focus state
    @State var selectedGroup: Group?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    var screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("enter amount")
                .padding(.top, 50)
            
            HStack {
                TextField("0.00", text: $price)
                    .font(.system(size: 60))
                    .bold()
                    .padding()
                    .textFieldStyle(PlainTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .keyboardType(.decimalPad)  // Numbers-only keyboard
                    .focused($isTextFieldFocused) // Bind focus state
            }
            
            
            NavigationLink {
                SelectGroupView(selectedGroup: $selectedGroup) // Pass the binding here
            } label: {
                Text(selectedGroup?.name ?? "Select a group") // Show selected group's name if exists
            }

            Spacer()
            
            Button {
                if let amount = Double(price){
                    if let group = selectedGroup {
                        let userID = viewModel.localUser.id
                        let allOtherUsers = group.users

                        DataModel.updateBalances(userID: userID, userIDs: allOtherUsers, groupID: group.id, amount: amount) { success in
                            
                            if success {
                                DispatchQueue.main.async {
                                    presentationMode.wrappedValue.dismiss()
                                }
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
            }
        }
        .padding(10)
        .navigationTitle("Add manually")
        .onAppear {
            if let group = selectedGroup {
                isTextFieldFocused = false
            }
            else{
                isTextFieldFocused = true // Focus text field on appear
            }
        }
    }
}

#Preview {
    AddManuallyView()
}
