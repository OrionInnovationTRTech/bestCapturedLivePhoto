//
//  LivePhotoViewModel.swift
//  BestCapturedLivePhoto
//
//  Created by Furkan Erdoğan on 22.07.2022.
//

import Foundation
import SwiftUI
import AVKit


class PhotosViewModel: ObservableObject {
    @Published var messages = "Messages inside observable object"
    
    @State var generator: AVAssetImageGenerator!
    var numberOfFrames = 12
    
    @State var videoFrames:[UIImage] = []
    
    
    
    @Published var photos: [ImageData] = [
        .init(id: 1, photoFrame: UIImage(named: "IMG_0070")!, qualityRequestText: "0.5"),
        .init(id: 2, photoFrame: UIImage(named: "IMG_0070")!, qualityRequestText: "0.3"),
        .init(id: 3, photoFrame: UIImage(named: "IMG_0070")!, qualityRequestText: "0.2"),
        .init(id: 2, photoFrame: UIImage(named: "IMG_0070")!, qualityRequestText: "0.3"),
        .init(id: 2, photoFrame: UIImage(named: "IMG_0070")!, qualityRequestText: "0.4"),
        .init(id: 2, photoFrame: UIImage(named: "IMG_0070")!, qualityRequestText: "0.6")
    
    ]
    
    func changeMessages() {
        self.messages = "BLAH BLAH BLAH"
    }
    
    func fetchPhotos() {
        imagesFromVideo(url: myGlobal!)
        
    }
    
    func imagesFromVideo(url: URL) {
        
        
          let asset = AVURLAsset(url: url)
          
          generator = AVAssetImageGenerator(asset: asset)
          generator.appliesPreferredTrackTransform = true
          generator.apertureMode = .encodedPixels
          let duration:Float64 = CMTimeGetSeconds(asset.duration)
          
          let frameInterval = duration/Double(numberOfFrames)
          
          var nsValues : [NSValue] = []
          
          for index in stride(from: 0, through: duration, by: frameInterval) {
              let cmTime  = CMTime(seconds: Double(index), preferredTimescale: 60)
              let nsValue = NSValue(time: cmTime)
              nsValues.append(nsValue)
          }
          
          self.getFrame(nsValues: nsValues)
  }
  
  
      
  private func getFrame(nsValues:[NSValue]) {
          
          var images : [UIImage] = []
          generator.generateCGImagesAsynchronously(forTimes: nsValues) { (time, cgImage, time2, result, error) in
              if let cgImage = cgImage{
                  images.append(UIImage(cgImage: cgImage))
              }
              if images.count == nsValues.count {
                  self.videoFrames = images
                  print("A1111: \(images.count)")
                  
              }
          }
  }
    
   
}
