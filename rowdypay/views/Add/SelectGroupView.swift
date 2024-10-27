//
//  SelectGroupView.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

struct SelectGroupView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var selectedGroup: Group? // Binding to pass selected group back
    @State var groups: [Group] = []
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ScrollView {
            VStack {
                ForEach(groups, id: \.self) { group in
                    Button(action: {
                        selectedGroup = group // Update selected group
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        GroupSubView(group: group)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                    }
                    .buttonStyle(.plain)
                    .padding()
                }
            }
            .padding(10)
        }
        .onAppear {
            fetchGroups()
        }
        .navigationTitle("Select a group")
    }
    
    func fetchGroups() {
        DataModel.getGroupsFromUser(id: viewModel.localUser.id) { groups in
            print(groups)
            self.groups = groups
        }
    }
}

#Preview {
    SelectGroupView(selectedGroup: .constant(Group()))
}
