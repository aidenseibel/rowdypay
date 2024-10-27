//
//  AddTab.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

struct AddTab: View {
//    @EnvironmentObject var viewModel: ViewModel
    
    var screenWidth = UIScreen.main.bounds.width

    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading, spacing: 40){
                    Text("How would you like to add a budget request?")
                    HStack(spacing: 15){
                        Image("sample_profile_image")
                            .resizable()
                            .frame(width: screenWidth * 0.25, height: screenWidth * 0.25)
                            .cornerRadius(10)
                            

                        VStack(alignment: .leading, spacing: 10){
                            Text("Add manually")
                                .font(.system(size: 22))
                                .bold()
                            Text("Enter the details manually")
                                .font(.system(size: 14))
                        }
                        Spacer()
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .stroke(Color.white, lineWidth: 1)
                    )

                    
                    HStack(spacing: 15){
                        Image("sample_profile_image")
                            .resizable()
                            .frame(width: screenWidth * 0.25, height: screenWidth * 0.25)
                            .cornerRadius(10)

                        VStack(alignment: .leading, spacing: 10){
                            Text("Scan a receipt")
                                .font(.system(size: 22))
                                .bold()
                            Text("Use our tool to read in details automatically")
                                .font(.system(size: 14))
                        }
                        Spacer()
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .stroke(Color.white, lineWidth: 1)
                    )
                }
                .padding(10)
            }
            .navigationTitle("Add a new request")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    AddTab()
}
