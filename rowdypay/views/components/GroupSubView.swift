//
//  GroupSubView.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

struct GroupSubView: View {
    var group: Group
    
    var screenWidth = UIScreen.main.bounds.width

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: group.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: screenWidth * 0.2, height: screenWidth * 0.2)
                    .cornerRadius(10)
            } placeholder: {
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: screenWidth * 0.2, height: screenWidth * 0.2)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(group.name)
                    .font(.system(size: 18))
                    .bold()
                Text("\(group.users.count) members")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding(.leading, 8)

            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    GroupSubView(group: Group())
}
