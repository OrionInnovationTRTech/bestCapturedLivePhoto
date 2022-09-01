# bestCapturedLivePhoto

# Introduction


The purpose of the Best Captured Live Photo application is to find the best quality photo in your selfie with the Live Photo feature that you took using your iPhone's camera. What is meant by the best quality photo is to divide the video into frames after taking the video part of the Live Photo and choose the one closest to the face among the frames. While making this choice, we use the Vision Framework that Apple introduced at WWDC 2017.


## Frameworks and Techs

Best Captured Live Photo uses a number of frameworks to work properly:

- [Vision] - The Vision framework performs face and face landmark detection, text detection, barcode recognition, image registration, and general feature tracking. Vision also allows the use of custom Core ML models for tasks like classification or object detection.
- [PhotoKit] - Work with image and video assets managed by the Photos app, including those from iCloud Photos and Live Photos.


## Installation

Download the application file and open a terminal inside the folder. Then run the following command.
you can run the command below and examine the application.

```sh
open BestCapturedLivePhoto.xcodeproj
```

## Images

<img src="https://github.com/furkanerdogan1/photosRe/blob/main/IMG_5104.PNGhttps://github.com/OrionInnovationTRTech/bestCapturedLivePhoto/blob/main/ScreenShots/IMG_5105.PNG" width="276" height="597" />  <img src="https://github.com/OrionInnovationTRTech/bestCapturedLivePhoto/blob/main/ScreenShots/IMG_5105.PNG" width="276" height="597" />




   [Vision]: <https://developer.apple.com/documentation/vision>
   [PhotoKit]: <https://developer.apple.com/documentation/photokit>
