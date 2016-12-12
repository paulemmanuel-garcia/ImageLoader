# ImageLoader
Simple image loader in swift

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
}```

*You can `cancel`/`suspend`/`restart` the request*
```swift
imageRequest.cancel()
imageRequest.suspend()
imageRequest.restart()
```

*To monitor the progress of the request you can implement the `ImageRequestDelegate`*
```swift
func progress(_ request: ImageRequest, totalBytesSent: Int64, totalBytesExpected: Int64) {
    print("\(Double(totalBytesSent) / Double(totalBytesExpected) * 100.0)%")
}
```

*If you do not want to start right away the loading of the image you can use the autoStart parameter*
```swift
let imageRequest = ImageLoader.default.request("https://assets-cdn.github.com/images/modules/open_graph/github-mark.png", autoStart = false) {
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
