//
//  UserAvatarView.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/27/24.
//

import SwiftUI
import Shimmer

struct UserAvatarView: View {
    let screenWidth = UIScreen.main.bounds.width
    
    let imageString: String
    
    var body: some View {
        ZStack{
            Circle()
                .frame(width: screenWidth * 0.50, height: screenWidth * 0.50)
                .cornerRadius(screenWidth * 0.35)
                .opacity(0.05)
                .padding()
            
            if let url = URL(string: imageString), UIApplication.shared.canOpenURL(url) {
                // If it's a URL, load asynchronously
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // Shows loading indicator
                            .frame(width: screenWidth * 0.3, height: screenWidth * 0.3)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: screenWidth * 0.70, height: screenWidth * 0.70)
                            .cornerRadius(screenWidth * 0.35)
                            .padding()
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    case .failure:
                        Image(systemName: "photo") // Placeholder for failed load
                            .resizable()
                            .frame(width: screenWidth * 0.70, height: screenWidth * 0.70)
                            .cornerRadius(screenWidth * 0.35)
                            .padding()
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                // Otherwise, assume it's a local asset
                Image(imageString)
                    .resizable()
                    .frame(width: screenWidth * 0.70, height: screenWidth * 0.70)
                    .cornerRadius(screenWidth * 0.35)
                    .padding()
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }


            Circle()
                .frame(width: screenWidth * 0.70, height: screenWidth * 0.70)
                .cornerRadius(screenWidth * 0.35)
                .padding()
                .opacity(0.10)
                .shimmering()
        }
    }
}

#Preview {
    UserAvatarView(imageString: "")
}
