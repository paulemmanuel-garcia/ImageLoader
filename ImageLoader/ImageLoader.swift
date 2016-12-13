//
//  ImageLoader.swift
//  ImageLoader
//
//  Created by Paul-Emmanuel on 11/12/16.
//  Copyright © 2016 rstudio. All rights reserved.
//

import UIKit

/// Completion
public typealias DownloadCompletion = (UIImage?, NSError?) -> (Void)

/// ImageLoader
@objc(RVSImageLoader)
public class ImageLoader: NSObject, URLSessionTaskDelegate {

    /// The default ImageLoader
    @objc(loader) public static let `default` = ImageLoader()

    /// Start the loading of an image.
    ///
    /// - Parameters:
    ///   - fromStr: String representation of the URL of the image
    ///   - completion: block called when the image's loading  is completed
    @objc(loadImageFrom:withCompletion:)
    public func load(image fromStr: String, completion: @escaping DownloadCompletion) {
        let _ = request(image: fromStr, completion: completion)
    }

    /// Create the ImageRequest which will be responsible to load the image.
    /// Do not keep a strong reference on the ImageRequest.
    ///
    /// - Parameters:
    ///   - fromStr: String representation of the URL of the image
    ///   - autoStart: the request should automatically start
    ///   - completion: block called when the image's loading  is completed
    /// - Returns: The ImageRequest, class responsible to load the image.
    @objc(requestImageFrom:autoStart:withCompletion:)
    public func request(image fromStr: String, autoStart: Bool = true, completion: @escaping DownloadCompletion) -> ImageRequest? {

        guard let imageURL = URL(string: fromStr) else {
            return nil
        }

        let imageRequest = ImageRequest(with: imageURL) {
            request in

            if let error = request.loadingError {
                DispatchQueue.main.async { completion(nil, error) }
                return
            }

            guard let data = request.imageData, let image = UIImage(data: data) else {
                DispatchQueue.main.async { completion(nil, NSError(domain: "com.rstudio.ImageLoader", code: 300, userInfo: [NSLocalizedDescriptionKey: "Unable to create UIImage."])) }
                return
            }

            DispatchQueue.main.async { completion(image, nil) }
        }

        if autoStart {
            imageRequest.start()
        }
        return imageRequest
    }
}

/// ImageRequestDelegate to be notify about events during the loading of the image
@objc(RVSImageRequestDelegate)
public protocol ImageRequestDelegate: class {
    
    /// Indicate the progress of the loading of the image
    ///
    /// - Parameters:
    ///   - request: the ImageRequest
    ///   - totalBytesSent: total bytes sent so far
    ///   - totalBytesExpected: total bytes expected, total size of the image
    @objc optional func progress(_ request: ImageRequest, totalBytesSent: Int64, totalBytesExpected: Int64)
}

/// The ImageRequest is responsible to download an image.
@objc(RVSImageRequest)
public class ImageRequest: NSObject, URLSessionDataDelegate {
    
    /// The image url that the request handles
    @objc public var imageURL: URL

    /// Delegate which will be notify during the progress
    @objc public weak var delegate: ImageRequestDelegate?

    /// Determine if the image should be cached
    @objc public var shouldCacheResult: Bool
    
    /// The raw data of the image
    fileprivate var imageData: Data?
    
    /// The possible error encountered by the download
    fileprivate var loadingError: NSError?

    /// The session which manages the download of the image
    private var session: URLSession?

    /// The task which download the image
    private var task: URLSessionDataTask!

    /// The total bytes expected (size of the image)
    private var totalBytesExpected: Int64

    /// The number of bytes being received
    private var totalBytesSent: Int64
    
    /// Closure executed once the image is downloaded.
    private var completionHandler: ((ImageRequest) -> (Void))?

    /// Initialize an ImageRequest which will handle
    /// the loading of a remote image.
    ///
    /// - Parameters:
    ///   - url: The url to load the image from
    ///   - completion: closure which will be executed once the image is downloaded
    @objc(initWithURL:completion:)
    init(with url: URL, completion: @escaping (ImageRequest) -> (Void)) {
        imageURL = url
        totalBytesExpected = 0
        totalBytesSent = 0
        completionHandler = completion
        shouldCacheResult = true
        super.init()
        session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        task = session?.dataTask(with: imageURL)
    }

    /// Cancel the loading of an image
    @objc public func cancel() {
        task?.cancel()
        session?.invalidateAndCancel()
    }

    /// Suspend the loading of an image
    @objc public func suspend() {
        task?.suspend()
    }

    /// Start the loading of an image
    @objc public func start() {
        task?.resume()
    }

    // MARK: - URLSessionDataDelegate implementation
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Swift.Void) {
        totalBytesExpected = response.expectedContentLength
        imageData = Data()
        completionHandler(.allow)
    }

    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        totalBytesSent += data.count
        imageData?.append(data)

        delegate?.progress?(self, totalBytesSent: totalBytesSent, totalBytesExpected: totalBytesExpected)

        // The loading of the image is now completed
        if totalBytesSent == totalBytesExpected {
            session.finishTasksAndInvalidate()
            completionHandler?(self)
        }
    }

    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Swift.Void) {
        if shouldCacheResult {
            completionHandler(proposedResponse)
            return
        }
        completionHandler(nil)
    }

    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            loadingError = error as NSError?
            session.finishTasksAndInvalidate()
            completionHandler?(self)
        }
    }
}

