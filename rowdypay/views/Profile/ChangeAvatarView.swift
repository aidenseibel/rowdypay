//
//  ChangeAvatarView.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/27/24.
//

import SwiftUI

struct ChangeAvatarView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 15){
                Text("Change your avatar")
                    .font(.system(size: 30))
                    .bold()
                    .padding(.top, 50)
                
                HStack(spacing: 20){
                    Button(action: {
                        viewModel.localUser.image = "car"
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("car")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.width * 0.45)
                    })
                    .background(Color(.darkGray))
                    .cornerRadius(10)

                    
                    Button(action: {
                        viewModel.localUser.image = "robot"
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("robot")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.width * 0.45)
                    })
                    .background(Color(.darkGray))
                    .cornerRadius(10)

                }

                HStack(spacing: 20){
                    Button(action: {
                        viewModel.localUser.image = "clock"
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("clock")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.width * 0.45)
                    })
                    .background(Color(.darkGray))
                    .cornerRadius(10)

                    
                    Button(action: {
                        viewModel.localUser.image = "scientist"
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("scientist")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.width * 0.45)
                    })
                    .background(Color(.darkGray))
                    .cornerRadius(10)

                }
            }
            .padding()
        }
    }
}

#Preview {
    ChangeAvatarView()
}
