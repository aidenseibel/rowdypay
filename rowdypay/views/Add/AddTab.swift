//
//  AddTab.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI

struct AddTab: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var navigationPath = NavigationPath()

    var screenWidth = UIScreen.main.bounds.width

    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading, spacing: 40){
                    NavigationLink {
                        AddManuallyView()
                    } label: {
                        HStack(spacing: 15){
                            VStack(alignment: .leading, spacing: 7){
                                Text("Add manually")
                                    .font(.system(size: 22))
                                    .bold()
                                Text("Enter the price details manually to add a request to a group.")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.gray)
                            }
                            Spacer()
                            
                            ZStack(alignment: .bottomTrailing){
                                Image("enter_manually_image")
                                    .resizable()
                                    .frame(width: screenWidth * 0.25, height: screenWidth * 0.45)
                                    .scaledToFill()
                                    .cornerRadius(10)
                                Image(systemName: "arrow.right.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(5)
                            }
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))

                        }
                        .padding()
                        .background(Color(.darkerGray))
                        .overlay(
                            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                    
                    NavigationLink {
                        ScanReceiptView(navigationPath: $navigationPath)
                    } label: {
                        HStack(spacing: 15){
                            VStack(alignment: .leading, spacing: 7){
                                Text("Scan a receipt")
                                    .font(.system(size: 22))
                                    .bold()
                                Text("Use your phone's camera to read a receipt and autofill the price details.")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.gray)
                            }
                            Spacer()

                            ZStack(alignment: .bottomTrailing){
                                Image("scan_receipt_image")
                                    .resizable()
                                    .frame(width: screenWidth * 0.25, height: screenWidth * 0.45)
                                    .scaledToFill()
                                    .cornerRadius(10)
                                Image(systemName: "arrow.right.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(5)
                            }
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                        }
                        .padding()
                        .background(Color(.darkerGray))
                        .overlay(
                            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                }
                .padding(10)
            }
            .navigationTitle("Add a new request")
            .navigationBarTitleDisplayMode(.large)
            .onAppear{
                viewModel.isTabBarShowing = true
            }
        }
    }
}

#Preview {
    AddTab()
}
