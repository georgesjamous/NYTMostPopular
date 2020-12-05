//
//  LiveeArticleRepositoryModels.swift
//  TestApp
//
//  Created by Georges on 12/5/20.
//  Copyright © 2020 Xeronium. All rights reserved.
//

import Foundation

// These objects reflect the article object models for NYTimesAPI
// specifically for 'http://api.nytimes.com/svc/mostpopular/v2/mostviewed/' request.
// Only the required values have been noted.
//

//
// For the time being this reponse is used as UIModel also

struct Article: Codable {
    let title : String
    let abstract : String
    let published_date : String
    let byline : String
    let media: [ArticleMedia]
    let column : String?
    let section: String?
    
    private enum CodingKeys : String, CodingKey {
        case title, abstract, published_date, byline, media, column, section, cached_url = ""
    }
    
    // getArticleMediaIcon returns one of the article's media url
    var cached_url: String?
    mutating func getArticleMediaIconURL() -> String? {
        if cached_url != nil {
            return cached_url
        }
        for m in media {
            let mUrl = m.getFirstMediaUrl()
            if mUrl != nil {
                cached_url = mUrl
                return mUrl
            }
        }
        return nil
    }
}

struct ArticleMedia: Codable {
    let type : String
    let subtype : String
    let mediaMetadata : [MediaMetadata]
    
    private enum CodingKeys : String, CodingKey {
        case type, subtype, mediaMetadata = "media-metadata"
    }
    
    // getFirstMediaUrl returns the first media url
    // for now, we will not check the size to make sure
    // we pick the appropriate one for display
    func getFirstMediaUrl() -> String? {
        guard type == "image" && subtype == "photo" else{
            return nil
        }
        for meta in mediaMetadata {
            let u = meta.url
            if u != "" {
                return u
            }
        }
        return nil
    }
}

struct MediaMetadata: Codable {
    let url : String
    let height: Int
    let width: Int
}

