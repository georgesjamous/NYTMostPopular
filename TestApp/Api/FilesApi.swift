//
//  FilesApi.swift
//  TestApp
//
//  Created by Georges Jamous on X/X/X.
//  Copyright © 2020 Georges Jamous. All rights reserved.
//

import Foundation

// FilesApi exposes the methods required for download a file.
final class FilesApi {
    
    enum FileError: Error {
        // InvalidImage error indicates that a corrupted or a non-image
        // typed file was returned.
        case InvalidImage
    }
    
    static let shared = FilesApi()
    
    // LoadImageFromUrl loads an image from a url.
    // MimeType must be an image or response will be discarded.
    public func LoadImageFromUrl(urlString: String, callback: @escaping HTTPClientCallback){
        LoadFileFromUrl(urlString: urlString) { (response, data, error) in
            guard let mimeType = response?.mimeType, mimeType.hasPrefix("image") else {
                callback(nil, nil, FileError.InvalidImage)
                return
            }
            callback(response, data, error)
        }
    }
    
    // LoadFileFromUrl loads an unknown file type.
    // No validations are performed.
    public func LoadFileFromUrl(urlString: String, callback: @escaping HTTPClientCallback){
        HTTPClient.shared.getRequest(urlString, completion: callback)
    }
}
