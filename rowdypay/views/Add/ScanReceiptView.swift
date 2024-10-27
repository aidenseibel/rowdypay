//
//  ScanReceiptView.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI
import UIKit

struct ScanReceiptView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Binding var navigationPath: NavigationPath

    @State var showImagePicker = false
    @State var image: UIImage? = nil
    @State var sourceType: UIImagePickerController.SourceType = .camera
    
    @State var navigateToConfirmation = false
    @State var analysisPrice: Double?

    let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 20) {
                if let uiImage = image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: screenWidth * 0.90, height: screenWidth * 1.10)
                        .clipped()
                } else {
                    VStack(alignment: .leading) {
                        Button(action: {
                            sourceType = .camera
                            showImagePicker = true
                        }) {
                            HStack{
                                Image(systemName: "camera.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.gray)
                                    .frame(width: 50, height: 50)
                                VStack(alignment: .leading, spacing: 2){
                                    Text("Open Camera")
                                        .bold()
                                    Text("Take a photo of your receipt")
                                        .font(.system(size: 12))
                                        .lineLimit(1)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(.darkGray)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                            
                        }
                        .buttonStyle(.plain)
                        
                        Button(action: {
                            sourceType = .photoLibrary
                            showImagePicker = true
                        }) {
                            HStack{
                                Image(systemName: "photo.on.rectangle")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.gray)
                                    .frame(width: 50, height: 50)
                                VStack(alignment: .leading, spacing: 2){
                                    Text("Use photo library")
                                        .bold()
                                    Text("Upload a photo of your receipt")
                                        .font(.system(size: 12))
                                        .lineLimit(1)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(.darkGray)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                        }
                        .buttonStyle(.plain)
                    }
                }
                                
                if let image = image{
                    Button {
                        DataModel.sendImageToOpenAI(image: image){ (success, price) in
                            if success {
                                // Set the price and trigger navigation
                                self.analysisPrice = price
                                self.navigateToConfirmation = true // Activate navigation
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Analyze")
                            Spacer()
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(.orange)
                        .cornerRadius(10)
                    }
                }
                
                // NavigationLink that is activated by the state variable
                NavigationLink(destination: ConfirmAddFromReceiptView(navigationPath: $navigationPath, price: analysisPrice ?? 10.0), isActive: $navigateToConfirmation) {
                    EmptyView() // This link is not shown in the UI
                }
            }
            .padding()
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image, sourceType: sourceType)
            }
            .navigationTitle("Scan a receipt")
            .onAppear{
                //            viewModel.isTabBarShowing = false
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var image: UIImage?

        init(image: Binding<UIImage?>) {
            _image = image
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                image = uiImage
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(image: $image)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

#Preview {
    ScanReceiptView(navigationPath: .constant(NavigationPath()))
}
