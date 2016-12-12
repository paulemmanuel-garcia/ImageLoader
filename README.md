# ImageLoader
Simple image loader in swift

[![Build Status](https://travis-ci.org/paulemmanuel-garcia/ImageLoader.svg?branch=master)](https://travis-ci.org/paulemmanuel-garcia/ImageLoader)
[![CocoaPods](https://img.shields.io/cocoapods/v/RVSImageLoader.svg)](https://cocoapods.org/pods/RVSImageLoader)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods](https://img.shields.io/cocoapods/l/RVSImageLoader.svg)](https://github.com/paulemmanuel-garcia/ImageLoader)
[![CocoaPods](https://img.shields.io/cocoapods/p/RVSImageLoader.svg)](https://github.com/paulemmanuel-garcia/ImageLoader)


## Usage

#### Import the library

To use it on your project you need to import the framework.
```swift
// Swift
import ImageLoader
```

#### General Use cases

- Simple load of an image:
*This will automatically start the loading of the image.*
```swift
ImageLoader.default.load("https://assets-cdn.github.com/images/modules/open_graph/github-mark.png") {
    image, error in
    self.imageView.image = image
}
```

- Handle image request:
```swift
let imageRequest = ImageLoader.default.request("https://assets-cdn.github.com/images/modules/open_graph/github-mark.png") {
    image, error in
    self.imageView.image = image
}
```

*You can `cancel`/`suspend`/`restart` the request*
```swift
imageRequest.cancel()
imageRequest.suspend()
imageRequest.start()
```

*To monitor the progress of the request you can implement the `ImageRequestDelegate`*
```swift
func progress(_ request: ImageRequest, totalBytesSent: Int64, totalBytesExpected: Int64) {
    print("\(Double(totalBytesSent) / Double(totalBytesExpected) * 100.0)%")
}
```

*If you do not want to start right away the loading of the image you can use the autoStart parameter*
```swift
let imageRequest = ImageLoader.default.request("https://assets-cdn.github.com/images/modules/open_graph/github-mark.png", autoStart: false) {
    image, error in
    self.imageView.image = image
}
// Do Stuff
imageRequest.start()
```

*By default images are cached, to disable that behavior:*
```swift
let imageRequest = ImageLoader.default("https://assets-cdn.github.com/images/modules/open_graph/github-mark.png") {
    image, error in
    self.imageView.image = image
}
imageRequest.shouldCacheResult = false
```
