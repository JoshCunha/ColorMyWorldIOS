//
//  HomeView.swift
//  ColorMyWorld
//
//  Created by Joshua Cunha on 2023-11-07.
//

import PhotosUI
import SwiftUI

struct HomeView: View {
    @State private var imagePicked: PhotosPickerItem?
    @State private var imageSet: Image?
    @State private var showCamera: Bool = false
    @State private var stackPath: [Int] = []
    
    var body: some View {
        NavigationStack(path: $stackPath) {
            VStack {
                Text("Welcome!").font(.system(size: 50)).bold()
                PhotosPicker(selection: $imagePicked, matching: .images, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.gray.opacity(0.7))
                        VStack {
                            Image(systemName: "photo")
                                .foregroundColor(Color.black)
                                .font(.system(size: 50))
                            Text("Upload a Picture")
                                .foregroundColor(Color.black)
                                .font(.system(size: 20))
                                .bold()
                        }
                    }.frame(width: UIScreen.main.bounds.width - 80, height: 100)
                }).padding(10).onChange(of: imagePicked) { _ in
                    Task {
                        if let data = try? await imagePicked?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                let passedImage = Image(uiImage: uiImage)
                                imageSet = passedImage
                            }
                        }
                    }
                }.onChange(of: imageSet) {_ in
                    Task {
                        stackPath.append(1)
                    }
                }
                
                Button {
                    showCamera = true
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.gray.opacity(0.7))
                        VStack {
                            Image(systemName: "camera")
                                .foregroundColor(Color.black)
                                .font(.system(size: 50))
                            Text("Take a Photo")
                                .foregroundColor(Color.black)
                                .font(.system(size: 20))
                                .bold()
                        }
                    }.frame(width: UIScreen.main.bounds.width - 80, height: 100)
                }.padding(10)
                
                Button {
                    getRandomPhoto()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.gray.opacity(0.7))
                        VStack {
                            Image(systemName: "arrow.2.squarepath")
                                .foregroundColor(Color.black)
                                .font(.system(size: 50))
                            Text("Get Random Image")
                                .foregroundColor(Color.black)
                                .font(.system(size: 20))
                                .bold()
                        }
                    }.frame(width: UIScreen.main.bounds.width - 80, height: 100)
                }.padding(10)
            }
        }.navigationDestination(for: Int.self) { value in
            ImageDisplayView(picture: imageSet)
        }.fullScreenCover(isPresented: $showCamera) {
            CameraPickerView() { image in
                imageSet = Image(uiImage: image)
            }
        }
    }
    
    func getRandomPhoto() {
        let urlString = "https://source.unsplash.com/random/600x600"
        let url = URL(string: urlString)!
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        if let uiImage = UIImage(data: data) {
            let gottenImage = Image(uiImage: uiImage)
            imageSet = gottenImage
        }
    }
}

struct CameraPickerView: UIViewControllerRepresentable {
    
    private var sourceType: UIImagePickerController.SourceType = .camera
    private let onImagePicked: (UIImage) -> Void
    
    @Environment(\.presentationMode) private var presentationMode
    
    public init(onImagePicked: @escaping (UIImage) -> Void) {
        self.onImagePicked = onImagePicked
    }
    
    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = self.sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(
            onDismiss: { self.presentationMode.wrappedValue.dismiss() },
            onImagePicked: self.onImagePicked
        )
    }
    
    final public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        private let onDismiss: () -> Void
        private let onImagePicked: (UIImage) -> Void
        
        init(onDismiss: @escaping () -> Void, onImagePicked: @escaping (UIImage) -> Void) {
            self.onDismiss = onDismiss
            self.onImagePicked = onImagePicked
        }
        
        public func imagePickerController(_ picker: UIImagePickerController,
                                          didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                self.onImagePicked(image)
            }
            self.onDismiss()
        }
        public func imagePickerControllerDidCancel(_: UIImagePickerController) {
            self.onDismiss()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
