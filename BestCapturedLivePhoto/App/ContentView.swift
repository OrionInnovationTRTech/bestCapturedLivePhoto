//
//  ContentView.swift
//  BestCapturedLivePhoto
//
//  Created by Furkan Erdoğan on 22.07.2022.
//

import SwiftUI
import AVKit
import Vision
import Photos
import UniformTypeIdentifiers
import MobileCoreServices

public var myGlobal: URL?

public var myGlobalLivePhoto: PHLivePhoto?



struct ContentView: View {
    
    //MARK: - PROPERTIES
    
    
    @ObservedObject var photoViewModel = PhotosViewModel()

    
    @State private var image: String?
    @State private var showSheet = false
    
    
    //MARK: - BODY
    
     @ViewBuilder var body: some View {
        
        NavigationView {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false)  {
                        HStack {
                            ForEach(self.photoViewModel.photos, id: \.id) { item in
                                 PhotoView(photo: item)
                            }
                            
                        }
                    }
                    
                    Image(uiImage: self.photoViewModel.bestPhoto ?? UIImage(named: "IMG_3340")! )
                        .resizable()
                        .scaledToFit()
                }
                
                .navigationBarTitle("Best Frame", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { self.showSheet = true
                            
                            
                        })  {
                          Image(systemName: "camera")
                        }
                        .popover(isPresented: $showSheet) {
                            ImagePicker(videoURL: $image)
                        }
                      }
                }
            
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            DispatchQueue.main.async {
                                self.photoViewModel.processLivePhoto(livePhoto: myGlobalLivePhoto!)
                            }
                            
                        })  {
                          Image(systemName: "arrow.2.squarepath")
                        }
                      }
                }
                
            
            
        }
        
    }
    
     
}

struct ContentView_Previews: PreviewProvider {
    
    static let  photos = [ImageData(id: UUID(), photoFrame: UIImage(named: "IMG_1679")!, qualityRequestText: "0.567"),
                                    ImageData(id: UUID(), photoFrame: UIImage(named: "IMG_8599")!, qualityRequestText: "0.767")
               ]
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}



