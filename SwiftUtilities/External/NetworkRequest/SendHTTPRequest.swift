//
//  SendHTTPRequest.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 5/4/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

import Foundation
import RxSwift


public enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    
}

public struct HTTPResponse {
    
    let data: Data?
    let response: URLResponse?
    let error: Swift.Error?
    
}

public func sendHTTPRequest(
    url: String,
    method: HTTPMethod = .get,
    header: [String: String] = [:],
    parameters: [String: Any] = [:]
) -> Observable<HTTPResponse> {
    var urlString = url
    
    if method.rawValue == "GET" {
        urlString += parameters.isEmpty ? "" : "?\(stringFromHttpParameters(parameters))"
    }
    
    guard let url = URL(string: urlString) else {
        return Observable.create({ observer in
            observer.onNext(HTTPResponse(
                data: nil,
                response: nil,
                error: NSError(domain: "urlString", code: -1, userInfo: nil)
            ))
            observer.onCompleted()
            
            return Disposables.create()
        })
    }
    var urlrequest = URLRequest(url: url)
    urlrequest.httpMethod = method.rawValue
    
    if method.rawValue == "POST" {
        urlrequest.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
    }
    
    for (key, value) in header {
        urlrequest.addValue(value, forHTTPHeaderField: key)
    }
    
    return Observable.create({ observer in
        let task = URLSession.shared.dataTask(with: urlrequest) { data, response, error in
            DispatchQueue.main.async {
                observer.onNext(HTTPResponse(data: data, response: response, error: error))
                observer.onCompleted()
            }
        }
        task.resume()
        
        return Disposables.create {
            task.cancel()
        }
    })
}

// MARK: - Privatem

private func stringFromHttpParameters(_ parameters: [String: Any]) -> String {
    return parameters.map({ key, value in
        let percentEscapedKey = stringByAddingPercentEncodingForURLQueryValue(key)!
        
        let percentEscapedValue: String
        
        if value is [AnyHashable: Any] || value is [Any] {
            let valueJSONData = try! JSONSerialization.data(withJSONObject: value, options: [])
            let valueJSONString = String(data: valueJSONData, encoding: .utf8)!
            percentEscapedValue = stringByAddingPercentEncodingForURLQueryValue(valueJSONString)!
        } else {
            percentEscapedValue = stringByAddingPercentEncodingForURLQueryValue("\(value)")!
        }
        
        return "\(percentEscapedKey)=\(percentEscapedValue)"
    }).joined(separator: "&")
}

private func stringByAddingPercentEncodingForURLQueryValue(_ string: String) -> String? {
    let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
    return string.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
}
