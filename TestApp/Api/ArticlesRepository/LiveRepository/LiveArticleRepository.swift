//
//  LibraryApi.swift
//  TestApp
//
//  Created by Georges Jamous on X/X/X.
//  Copyright © 2020 Georges Jamous. All rights reserved.
//

import Foundation

// ArticleRepository abstracts the more complex HTTPClient methods in a usable manner.
final class LiveArticleRepository: ArticleRepositoryInterface {
    // For the time being, api keys and base url will be stored here,
    // since there is no way to aqcuire an api key.
    // In practice, credentials can/should be stored in keychain service.
    private enum Constants {
        static let BaseUrl = "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json"
        static let ApiKey = "RrldVEumHP67Rb6OGkICkcJKvr1DP2EH"
    }
    // Private response
    struct Response: Codable {
        let status: String
        let num_results: Int
        let results: [Article]
    }
    // fetchArticlesFromServer async fetches the list of articles
    func fetchMostPopular(callback: @escaping (Result<[Article], ArticleRepositoryError>) -> Void) {
        let url = "\(Constants.BaseUrl)?api-key=\(Constants.ApiKey)"
        HTTPClient.shared.getRequest(url) { (response, data, error) in
            if let error = error {
                callback(.failure(.general(error)))
                return
            }
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    callback(.success(response.results))
                } catch _ {
                    callback(.failure(.general(HTTPClient.RequestError.DataCorrupted)))
                }
            } else {
                callback(.failure(.general(HTTPClient.RequestError.DataCorrupted)))
            }
        }
    }
    
}
