//
//  PhotosViewModel.swift
//  BestCapturedLivePhoto
//
//  Created by Furkan Erdoğan on 22.07.2022.
//

import Foundation
import SwiftUI
import AVKit
import Photos
import UniformTypeIdentifiers
import MobileCoreServices
import Vision


class PhotosViewModel: ObservableObject {
    
    //MARK: - PROPERTIES
    
    private let workQueue = DispatchQueue(label: "VisionRequest", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)

    
    
    @Published var videoFrames: [UIImage] = []{
        didSet{
            DispatchQueue.main.async {
                self.setCustomData()
            }
        }
    }
    
    @Published var bestPhoto =  UIImage(named: "IMG_3340")
    
    @Published var photos : [ImageData] = []
    
    @Published var generator: AVAssetImageGenerator!
    var numberOfFrames = 15
    
    
    
    @Published var videoUrl : URL? {
            didSet{
                DispatchQueue.global(qos: .background).async {
                    guard let videoURL = self.videoUrl else{ return }
                    self.imagesFromVideo(url: videoURL)
                }
            }
    }
    
    //MARK: - FUNCTIONS
    
    //: Canlı Fotoğrafın kaynaklarına ulaşıyoruz: assetResources
    
    func processLivePhoto(livePhoto: PHLivePhoto)
        {
            let livePhotoResources = PHAssetResource.assetResources(for: livePhoto)
            guard let photoDir = generateFolderForLivePhotoResources() else{ return }
            for resource in livePhotoResources {
                
                if resource.type == PHAssetResourceType.pairedVideo {
                    saveAssetResource(resource: resource, inDirectory: photoDir, buffer: nil, maybeError: nil)
                }
            }
        }
    
    //: Alınan videoyu yerel bir dosyaya yazıyoruz
        
        func saveAssetResource(resource: PHAssetResource, inDirectory: NSURL, buffer: NSMutableData?, maybeError: Error?) -> Void {
            guard maybeError == nil else { return }
            
            let maybeExt = UTTypeCopyPreferredTagWithClass(resource.uniformTypeIdentifier as CFString, kUTTagClassFilenameExtension)?.takeRetainedValue()
            
            guard let ext = maybeExt else {
                return
            }
            
            guard var fileUrl = inDirectory.appendingPathComponent(NSUUID().uuidString) else {
                print("DEBUG: Error is file url ")
                return
            }
            
            fileUrl = fileUrl.appendingPathExtension(ext as String)
            
            if let buffer = buffer, buffer.write(to: fileUrl, atomically: true) {
                self.videoUrl = fileUrl
            } else {
                PHAssetResourceManager.default().writeData(for: resource, toFile: fileUrl, options: nil) { (error) in
                    
                    DispatchQueue.main.async {
                        self.videoUrl = fileUrl
                        
                    }
                    
                }
            }
        }
        
        func generateFolderForLivePhotoResources() -> NSURL? {
            let photoDir = NSURL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent(NSUUID().uuidString)
            
            let fileManager = FileManager()
            let success : ()? = try? fileManager.createDirectory(at: photoDir!, withIntermediateDirectories: true, attributes: nil)
            
            return success != nil ? photoDir! as NSURL : nil
        }
    
    //: Videoyu karelere ayırmak için kullanılan iki fonksiyon
    
    func imagesFromVideo(url: URL) {
            let asset = AVURLAsset(url: url)
            
        DispatchQueue.main.async {
            self.generator = AVAssetImageGenerator(asset: asset)
            self.generator.appliesPreferredTrackTransform = true
            self.generator.apertureMode = .encodedPixels
            let duration:Float64 = CMTimeGetSeconds(asset.duration)
            
            let frameInterval = duration/Double(self.numberOfFrames)
            
            var nsValues : [NSValue] = []
            
            //: Başlangıç bitişi alıyoruz stride ile 0'dan ...
            
            for index in stride(from: 0, through: duration, by: frameInterval) {
                let cmTime  = CMTime(seconds: Double(index), preferredTimescale: 60)
                let nsValue = NSValue(time: cmTime)
                nsValues.append(nsValue)
            }
            
            self.getFrame(nsValues: nsValues)
        }
    }
    
    //: Image dizisi yaratıyoruz: generateCGImagesAsynchronously
        
    private func getFrame(nsValues:[NSValue]) {
        
        var images : [UIImage] = []
        generator.generateCGImagesAsynchronously(forTimes: nsValues) { (time, cgImage, time2, result, error) in
            DispatchQueue.main.async {
                if let cgImage = cgImage{
                    images.append(UIImage(cgImage: cgImage))
                }
                if images.count == nsValues.count{
                    self.videoFrames = images
                }
            }
        }
        
        
    }
    
    
    
    func setCustomData(){
        
        
        photos = []
        print("DEBUG: Video frames count \(videoFrames.count)")
        DispatchQueue.main.async {
            for frame in self.videoFrames{
                let customData = ImageData(photoFrame: frame)
                self.photos.append(customData)
            }
            self.visionRequest()
        }
        
    }
    
    //: Yüze en yakın görüntüyü seçmek için fonksiyon
    
     func visionRequest(){
              
        var bestFrameValue : Float = 0.0
        var bestFrameIndex = -1
            

            workQueue.async {
                
                print("DEBUG: Photos count \(self.photos.count)")
                
                for i in 0..<self.photos.count
                {
                    guard let cgImage = self.photos[i].photoFrame.cgImage else {return}
                    
                    //: Karelere ayırdığımız resimlerin hepsinin üzerinden geçip VNDetectFaceCaptureQualityRequest ile dönen float sayıya göre karşılatırıyoruz
                    let request = VNDetectFaceCaptureQualityRequest()
                    
                    
                    let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
                    do{
                        try requestHandler.perform([request])
                        if let faceObservation = request.results?.first as? VNFaceObservation{
                            if let faceCaptureQuality = faceObservation.faceCaptureQuality{
                                self.photos[i].qualityRequestText = "\(faceCaptureQuality * 10)"
                                if faceCaptureQuality > bestFrameValue{
                                    bestFrameValue = faceCaptureQuality
                                    bestFrameIndex = i
                                }
                            }
                        }
                        else{
                            self.photos[i].qualityRequestText = "0.00"
                        }

                    }catch(let error){
                        print("DEBUG: Error is \(error.localizedDescription)")
                    }
                }
                
                DispatchQueue.main.async {
                    
                    if bestFrameIndex != -1{
                        self.bestPhoto = self.photos[bestFrameIndex].photoFrame
                    }
                }
            }
        }
    
    
}
