//
//  ScanReceiptView.swift
//  rowdypay
//
//  Created by Aiden Seibel on 10/26/24.
//

import SwiftUI
import UIKit

struct ScanReceiptView: View {
    @Binding var navigationPath: NavigationPath

    @State private var showImagePicker = false
    @State private var image: UIImage? = nil
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @State private var navigateToConfirmation = false
    @State private var analysisPrice: Double?


    var body: some View {
        VStack {
            Spacer()
            
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } else {
                Text("No Image Selected")
                    .foregroundColor(.gray)
            }

            HStack {
                Button(action: {
                    sourceType = .camera // Choose Camera
                    showImagePicker = true
                }) {
                    Text("Open Camera")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: {
                    sourceType = .photoLibrary // Choose Photo Library
                    showImagePicker = true
                }) {
                    Text("Open Photo Library")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }

            Spacer()
            
            Button {
                if let image = image {
                    DataModel.sendImageForAnalysis(image: image) { (success, price) in
                        if success {
                            // Set the price and trigger navigation
                            self.analysisPrice = price
                            self.navigateToConfirmation = true // Activate navigation
                        }
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

            // NavigationLink that is activated by the state variable
            NavigationLink(destination: ConfirmAddFromReceiptView(navigationPath: $navigationPath, price: analysisPrice ?? 10.0), isActive: $navigateToConfirmation) {
                EmptyView() // This link is not shown in the UI
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $image, sourceType: sourceType)
        }
        .navigationTitle("Scan a receipt")
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
