//
//  CreateGroup.swift
//  rowdypay
//
//  Created by Khoi Tran on 10/26/24.
//

import SwiftUI

struct CreateGroup: View {
    @State private var name: String = ""
    @State private var img: String = ""
    @State private var users: [Int] = []
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        VStack{
            TextField("Enter Group Name", text: $name)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray6))
                )
            TextField("Pick Photo", text: $img)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray6))
                )
        }
    }
}

#Preview {
    CreateGroup()
}
