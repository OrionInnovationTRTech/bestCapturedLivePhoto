//
//  SelectedPhotoView.swift
//  BestCapturedLivePhoto
//
//  Created by Furkan Erdoğan on 9.08.2022.
//

import SwiftUI

struct SelectedPhotoView: View {
    
    //: MARK: - PROPERTIES
    
    let image: UIImage
    let text: String
    
    @State private var isAnimatingImage: Bool = false
    
    
    //: MARK: - BODY
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(height: 400)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                .padding(.vertical, 20)
                .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
            
            Text(text)
                .font(.headline)
        }.onAppear() {
            withAnimation(.easeOut(duration: 0.5)) {
              isAnimatingImage = true
            }
          }
    }
}


//: MARK: - PREVIEW

struct SelectedPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedPhotoView(image: UIImage(named: "IMG_2127")!, text: "0.00")
    }
}
