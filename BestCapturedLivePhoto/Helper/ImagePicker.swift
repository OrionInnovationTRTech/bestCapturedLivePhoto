//
//  ImagePicker.swift
//  BestCapturedLivePhoto
//
//  Created by Furkan Erdoğan on 22.07.2022.
//

import SwiftUI
import PhotosUI
import Photos

struct ImagePicker: UIViewControllerRepresentable{
    
    @Binding var videoURL:String?

func makeUIViewController(context: Context) -> PHPickerViewController {
    

        var config = PHPickerConfiguration()
        config.filter = .livePhotos
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
        
    }
    
    
    class Coordinator:NSObject, PHPickerViewControllerDelegate{
        
        
        let parent:ImagePicker
        init(_ parent: ImagePicker){
            self.parent = parent
            
        }
        
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // The client is responsible for presentation and dismissal
        picker.dismiss (animated: true)

        // Get the first item provider from the results
        let itemProvider = results.first?.itemProvider

        // Access the UIImage representation for the result
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: PHLivePhoto.self) {
                itemProvider.loadObject(ofClass: PHLivePhoto.self) {  image, error in
                    if let image = image {
                      // Do something with the UIImage
                        myGlobalLivePhoto = image as? PHLivePhoto
                     }
            }
        }
        
    }
    
}
}
