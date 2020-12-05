//
//  URLImageView.swift
//  TestApp
//
//  Created by Georges Jamous on X/X/X.
//  Copyright © 2020 Georges Jamous. All rights reserved.
//

import UIKit

// URLImageView is a custom UIImageView class with a loader
class URLImageView: UIImageView {
    
    private var currentUrl: String?
    private var activityIndicator: UIActivityIndicatorView
    
    init() {
        activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
        
        super.init(frame: CGRect.zero)
        self.addSubview(activityIndicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.frame = self.bounds
    }
    
    public func loadFromURL(url: String){
        // ignore duplicate requests
        // this will solve blinking problem
        if currentUrl == url && self.image != nil {
            return
        }
        image = nil
        currentUrl = url
        activityIndicator.startAnimating()
        downloadImage(url: url)
    }
    
    private func downloadImage(url: String){
        FilesApi.shared.LoadImageFromUrl(urlString: url) {
            [weak self] (_, data, error) in
            if error == nil, let data = data {
                self?.downloadCompletedForUrl(data: data, url: url)
            }
        }
    }
    
    private func downloadCompletedForUrl(data: Data, url: String){
        // check if a later issued request has
        // replaced the url being loaded
        if url != currentUrl {
            return
        }
        // We dispatch to a background queue to offload
        // the work to decode data into image, then
        // set it back on the main thread
        DispatchQueue.global(qos: .userInitiated).async {
            let i = UIImage(data: data)
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.image = i
            }
        }
    }
}

