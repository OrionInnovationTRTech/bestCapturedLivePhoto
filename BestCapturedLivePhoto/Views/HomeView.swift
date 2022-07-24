//
//  HomeView.swift
//  BestCapturedLivePhoto
//
//  Created by Furkan Erdoğan on 22.07.2022.
//

import Foundation
import SwiftUI
import Vision
import AVFoundation
import AssetsLibrary

public var myGlobal: URL?

struct ContentView: View {
    
    @ObservedObject var photoViewModel = PhotosViewModel()
    
    @State private var image: String?
    @State private var showSheet = false
    @State var generator: AVAssetImageGenerator!
    var numberOfFrames = 12
    
    @State var videoFrames:[UIImage] = []
    
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal) {
                VStack {
                    HStack(alignment: .top) {
                        ForEach(photoViewModel.photos, id: \.id) { box in
                                
                            BoxView(box: box)
                             
                        }
                        
                    }
                }
                
                
            }.padding()
                .navigationBarTitle("Photos")
                .navigationBarItems(trailing: Button(action: {
                    print("Fetching Data")
                    
                    
                    
                }, label: {
                    Text("Show Photos")
                }))
                .navigationBarItems(trailing: Button(action: {
                    print("Fetching Data")
                    
                    self.photoViewModel.fetchPhotos()
                    
                    
                    
                }, label: {
                    Text("Fetch Photos")
                })).navigationBarItems(trailing: Button(action: { self.showSheet = true
                    print("Fetching Data")
                       
                    
                }, label: {
                    Text("Select Photo")
                })).sheet(isPresented: $showSheet) {
                    VideoPicker(videoURL: $image)
                }
                
        }
    }
    
    
    
    
}

struct BoxView: View {
    
    let box: ImageData
    
    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: box.photoFrame)
                .resizable()
                .cornerRadius(12)
                .frame(width: 80, height: 80)
            Text(box.qualityRequestText)
                .font(.subheadline)
                .fontWeight(.bold)
            
            Color .clear
                
        }
        
        
    }
        
}



