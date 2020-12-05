//
//  HttpClientTests.swift
//  TestAppTests
//
//  Created by Georges Jamous on 3/3/19.
//  Copyright © 2020 Georges Jamous. All rights reserved.
//

import XCTest
@testable import TestApp

class HttpClientTests: XCTestCase {
    
    // HTTPClient_T is a helper wrapper for our test
    class HTTPClient_T: HTTPClient {
        var count = 0
        
        override init() {
            super.init()
        }
        
        static let shared_T = HTTPClient_T()
        
        override func performRequest(url: URL) {
            super.performRequest(url: url)
            count = count + 1
        }
    }

    func testCallbackCalleOnMainUI(){
        let url = "https://www.google.com";
        HTTPClient_T.shared_T.getRequest(url) { (r, d, e) in
            XCTAssertTrue( Thread.current.isMainThread)
        }
    }
    
    func testPerformMultipleGetRequestsOnlyOnce(){
        let url = "https://www.google.com";
        
        HTTPClient_T.shared_T.getRequest(url) { (r, d, e) in }
        HTTPClient_T.shared_T.getRequest(url) { (r, d, e) in }
        HTTPClient_T.shared_T.getRequest(url) { (r, d, e) in }
        HTTPClient_T.shared_T.getRequest(url) { (r, d, e) in }
        
        XCTAssertTrue(HTTPClient_T.shared_T.count == 1)
    }
    
    func testFailsWhenUrlIsInvalid(){
        HTTPClient_T.shared_T.getRequest("") { (r, d, e) in
            XCTAssertTrue(e is HTTPClient.RequestError)
            XCTAssertTrue(e?.localizedDescription == HTTPClient.RequestError.InvalidUrl.localizedDescription)
        }
    }
}
