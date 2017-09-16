//
//  Data+Extension.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

import Foundation


extension Data {
    
    public func split(maximumSizeInBytes: Int) -> [Data] {
        let fullChunks = count / maximumSizeInBytes
        
        let result = (0..<fullChunks).map({ i -> Data in
            let location = i * maximumSizeInBytes
            return subdata(in: location..<location + maximumSizeInBytes)
        })
        
        let finalChunkSize = count % maximumSizeInBytes
        
        if finalChunkSize == 0 {
            return result
        }
        
        let location = fullChunks * maximumSizeInBytes
        return result + [subdata(in: location..<location + finalChunkSize)]
    }
    
}
