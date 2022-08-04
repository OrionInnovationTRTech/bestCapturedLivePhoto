//
//  PhotoView.swift
//  BestCapturedLivePhoto
//
//  Created by Furkan Erdoğan on 4.08.2022.
//

import SwiftUI

struct PhotoView: View {
    //MARK: - PROPERTIES
    
    let photo: ImageData
    
    //MARK: - BODY
    
    
    var body: some View {
        VStack {
            Image(uiImage: photo.photoFrame)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            
            Text(photo.qualityRequestText)
                .font(.headline)
        }
    }
}


//MARK: - PREVIEWS

struct PhotoView_Previews: PreviewProvider {
    
    static let photos: [ImageData] = [ImageData(id: UUID(), photoFrame: UIImage(named: "IMG_1679")!, qualityRequestText: "0.567")]
    
    static var previews: some View {
        PhotoView(photo: photos[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
