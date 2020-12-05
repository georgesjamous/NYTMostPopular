//
//  ArticleRepositoryInterface.swift
//  TestApp
//
//  Created by Georges on 12/5/20.
//  Copyright © 2020 Xeronium. All rights reserved.
//

import Foundation

protocol ArticleRepositoryInterface {
    func fetchMostPopular(callback: @escaping (Result<[Article], ArticleRepositoryError>) -> Void)
}

// MARK: Errors

enum ArticleRepositoryError: Error {
    // lists repository specific errors
    case general(Error)
}

// MARK: Models

// for now we are using the reeponse models directly
