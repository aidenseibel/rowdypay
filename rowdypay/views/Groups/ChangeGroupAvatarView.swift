//
//  ChangeGroupAvatarView.swift
//  rowdypay
//
//  Created by Khoi Tran on 10/27/24.
//

import SwiftUI

struct ChangeGroupAvatarView: View {
   @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   @Binding var selectedImage: String
   
   var body: some View {
       ScrollView {
           VStack(alignment: .leading, spacing: 15) {
               Text("Change Group Avatar")
                   .font(.system(size: 30))
                   .bold()
                   .padding(.top, 50)
               
               HStack(spacing: 20) {
                   Button(action: {
                       selectedImage = "group_image1"
                       presentationMode.wrappedValue.dismiss()
                   }, label: {
                       Image("group_image1")
                           .resizable()
                           .scaledToFill()
                           .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.width * 0.45)
                   })
                   .background(Color(.darkGray))
                   .cornerRadius(10)
                   
                   Button(action: {
                       selectedImage = "group_image2"
                       presentationMode.wrappedValue.dismiss()
                   }, label: {
                       Image("group_image2")
                           .resizable()
                           .scaledToFill()
                           .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.width * 0.45)
                   })
                   .background(Color(.darkGray))
                   .cornerRadius(10)
               }
               
               HStack(spacing: 20) {
                   Button(action: {
                       selectedImage = "group_image3"
                       presentationMode.wrappedValue.dismiss()
                   }, label: {
                       Image("group_image3")
                           .resizable()
                           .scaledToFill()
                           .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.width * 0.45)
                   })
                   .background(Color(.darkGray))
                   .cornerRadius(10)
                   
                   Button(action: {
                       selectedImage = "group_image4"
                       presentationMode.wrappedValue.dismiss()
                   }, label: {
                       Image("group_image4")
                           .resizable()
                           .scaledToFill()
                           .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.width * 0.45)
                   })
                   .background(Color(.darkGray))
                   .cornerRadius(10)
               }
               
               HStack(spacing: 20) {
                   Button(action: {
                       selectedImage = "group_image5"
                       presentationMode.wrappedValue.dismiss()
                   }, label: {
                       Image("group_image5")
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
