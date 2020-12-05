//
//  HttpClient.swift
//  TestApp
//
//  Created by Georges Jamous on X/X/X.
//  Copyright © 2020 Georges Jamous. All rights reserved.
//

import Foundation

typealias HTTPClientRequestResult = (URLResponse?, Data?, Error?)
typealias HTTPClientCallback = (URLResponse?, Data?, Error?)->()

class HTTPClient {
    enum RequestError: Error {
        // InvalidUrl error indicates that an invalid URL was passed
        case InvalidUrl
        // RequestFailed error indicates that the request has failed
        // Note: this error will mask any error returned from the response
        // since we do not care about them for the time being
        case RequestFailed
        case NoInternetConnection
        // DataCorrupted error indicates that the received data could not be parsed
        case DataCorrupted
    }
    
    static let shared = HTTPClient()
    
    // activeOperations contains the current non-completed requests
    private var activeOperations = [URL: [HTTPClientCallback]]()
    
    // the shared URL session is used here since it handles cached data internally.
    // This is fine for our use case since we do not need a complex caching mechanism,
    // nor control over the cache.
    let session = URLSession.shared

    // getRequest is the raw operating function, will return the data or an error.
    // Simultaneous requests with same url are executed only once to save data usage.
    func getRequest(_ urlString: String,  completion: @escaping HTTPClientCallback) {
        guard let url = URL(string: urlString) else {
            completion(nil, nil, RequestError.InvalidUrl)
            return
        }
        SyncUtils.Synchronize(lock: activeOperations as AnyObject) {
            if activeOperations.keys.contains(url) {
                // wait for previous request
                activeOperations[url]?.append(completion)
            }else{
                activeOperations[url] = [completion]
                performRequest(url: url)
            }
        }
    }
    
     func performRequest(url: URL) {
        session.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            guard let completionHandlers = self?.activeOperations[url] else { return }
            
            SyncUtils.Synchronize(lock: self?.activeOperations as AnyObject) {
                self?.activeOperations.removeValue(forKey: url)
            }
            
            var requestResult :HTTPClientRequestResult?
            
            // .statusCode == 200 is assumed per standard GET requests RFC2616.
            if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode != 200 {
                self?.notifyHandlers(
                    handlers: completionHandlers,
                    result: (response, nil, RequestError.RequestFailed)
                )
                return
            }
            
            if let error = error {
                if let err = error as? URLError, err.code  == URLError.Code.notConnectedToInternet{
                    requestResult = (response, nil, RequestError.NoInternetConnection)
                } else {
                    requestResult = (response, nil, RequestError.RequestFailed)
                }
                self?.notifyHandlers( handlers: completionHandlers, result: requestResult)
                return
            }
            
            if let data = data {
                self?.notifyHandlers(handlers: completionHandlers, result: (response, data, nil))
                return
            }
        }).resume()
    }
    
    // notifyHandlers invokes handlers on main queue
    private func notifyHandlers(handlers: [HTTPClientCallback], result: HTTPClientRequestResult?){
        let r = result ?? (nil, nil, nil)
        DispatchQueue.main.async {
            for handler in handlers {
                handler(r.0, r.1, r.2)
            }
        }
    }
}
