//
//  SendAPIRequest.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 5/4/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

import RxSwift
import SwiftyJSON


public func sendAPIRequest(
    url: String,
    method: HTTPMethod = .get,
    header: [String: String] = [:],
    parameters: [String: Any] = [:]
) -> Observable<Result<JSON, APIRequestError>> {
    let header = header + [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    return sendHTTPRequest(url: url, method: method, header: header, parameters: parameters).map({ httpResponse in
        if let error = httpResponse.error {
            if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                return Result.failure(.noInternet)
            }
            
            return Result.failure(.serverIssue("\(error)"))
        }
        
        guard let data = httpResponse.data else {
            return Result.failure(.serverIssue("No data"))
        }
        
        guard let response = httpResponse.response as? HTTPURLResponse else {
            return Result.failure(.responseError)
        }
        
        let json = JSON(data)
        
        guard !json.isNull() else {
            return Result.failure(.unableToParseJSON)
        }
        
        switch response.statusCode {
        case 200:
            return Result.success(JSON(json))
        default:
            return Result.failure(.statusCode(response.statusCode))
        }
    })
}
