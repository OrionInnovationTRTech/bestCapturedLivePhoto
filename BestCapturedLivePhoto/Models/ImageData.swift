//
//  ImageData.swift
//  BestCapturedLivePhoto
//
//  Created by Furkan Erdoğan on 22.07.2022.
//

import Foundation
import SwiftUI

struct ImageData: Identifiable {
    var id = UUID()
    var photoFrame: UIImage
    var qualityRequestText: String = ""
}
