//
//  SendAPIRequest.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 5/4/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

import RxSwift
import SwiftyJSON


func sendAPIRequest(
    url: String,
    method: HTTPMethod = .get,
    header: [String: String] = defaultHeader,
    parameters: [String: String] = [:]
) -> Observable<Result<JSON, APIRequestError>> {
    return sendHTTPRequest(url: url, method: method, header: header, parameters: parameters).map({ httpResponse in
        guard let data = httpResponse.data, httpResponse.error == nil else {
            if (httpResponse.error! as NSError).code == NSURLErrorNotConnectedToInternet {
                return Result.failure(.noInternet)
            } else {
                return Result.failure(.serverIssue("Error"))
            }
        }
        
        guard let json = (try? JSONSerialization.jsonObject(
            with: data,
            options: JSONSerialization.ReadingOptions()
        )) else {
            return Result.failure(.serverIssue("Unable to parse JSON"))
        }
        
        guard let response = httpResponse.response as? HTTPURLResponse else {
            return Result.failure(.serverIssue("Network response error"))
        }
        
        switch response.statusCode {
        case 200:
            return Result.success(JSON(json))
        default:
            return Result.failure(.serverIssue("Unknown network error"))
        }
    })
}

// MARK: - Private

private let defaultHeader = [
    "Content-Type": "application/json",
    "Accept": "application/json"
]
