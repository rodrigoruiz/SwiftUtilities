//
//  APIRequestError.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 5/4/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

enum APIRequestError {
    
    case noInternet
    case serverIssue(String)
    
}

func == (lhs: APIRequestError, rhs: APIRequestError) -> Bool {
    switch (lhs, rhs) {
    case (.noInternet, .noInternet):
        return true
    case let (.serverIssue(s1), .serverIssue(s2)):
        return s1 == s2
    default:
        return false
    }
}
