//
//  Regex.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 8/30/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public struct Regex {
    
    public init?(_ pattern: String) {
        self.init(pattern: pattern, options: [])
    }
    
    public init?(pattern: String, options: NSRegularExpression.Options) {
        guard let regularExpression = try? NSRegularExpression(pattern: pattern, options: options) else {
            return nil
        }
        
        self.regularExpression = regularExpression
    }
    
    public func matches(_ string: String) -> [Match] {
        return matches(in: string, options: [])
    }
    
    public func matches(in string: String, options: NSRegularExpression.MatchingOptions) -> [Match] {
        let matches = regularExpression.matches(
            in: string,
            options: options,
            range: NSRange(location: 0, length: string.length)
        )
        
        return matches.map({ match in
            let lastIndex = match.numberOfRanges - 1
            
            return Match(
                full: (range: match.range, string: string[match.range]),
                groups: 1 <= lastIndex ?
                    (1...lastIndex)
                        .map(match.range)
                        .map({ (range: $0, string: string[$0]) })
                    : []
            )
        })
    }
    
    // MARK: - Private
    
    private let regularExpression: NSRegularExpression
    
}

extension Regex {
    
    public struct Match {
        
        public let full: (range: NSRange, string: String)
        public let groups: [(range: NSRange, string: String)]
        
    }
    
}
