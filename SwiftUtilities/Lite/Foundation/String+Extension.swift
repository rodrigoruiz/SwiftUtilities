//
//  String+Extension.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension String {
    
    public var length: Int {
        return characters.count
    }
    
    public subscript(i: Int) -> String {
        guard i >= 0 && i < characters.count else { return "" }
        return String(self[index(startIndex, offsetBy: i)])
    }
    
    public subscript(range: Range<Int>) -> String {
        let lowerIndex = index(
            startIndex,
            offsetBy: max(0, range.lowerBound),
            limitedBy: endIndex
        ) ?? endIndex
        
        let upperIndex = index(
            startIndex,
            offsetBy: range.upperBound,
            limitedBy: endIndex
        ) ?? endIndex
        
        return substring(with: lowerIndex..<upperIndex)
    }
    
    public subscript(range: ClosedRange<Int>) -> String {
        return self[range.lowerBound..<(range.upperBound + 1)]
    }
    
    public subscript(range: NSRange) -> String {
        if range.length == 0 {
            return ""
        }
        
        return self[range.location...range.location + range.length - 1]
    }
    
    public func indexOfCharacter(char: Character) -> Int? {
        if let idx = characters.index(of: char) {
            return characters.distance(from: startIndex, to: idx)
        }
        return nil
    }
    
    public func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    public func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    public func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    public func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
    
    public func split(_ separator: String) -> [String] {
        return components(separatedBy: separator)
    }
    
    public func format(_ format: String, replacementCharacter: String) -> String {
        var string = self
        var format = format
        
        var result = ""
        
        while !string.isEmpty && !format.isEmpty {
            if format[0] == replacementCharacter {
                result += string[0]
                string.remove(at: string.startIndex)
            } else {
                result += format[0]
            }
            
            format.remove(at: format.startIndex)
        }
        
        return result
    }
    
    public func take(_ numberOfElements: Int) -> String {
        return Array(characters.map({ "\($0)" })).take(numberOfElements).joined()
    }
    
    public func remove(charactersIn characterSet: CharacterSet) -> String {
        return components(separatedBy: characterSet).joined()
    }
    
}

public func take(_ numberOfElements: Int) -> (String) -> String {
    return { $0.take(numberOfElements) }
}

public func remove(charactersIn characterSet: CharacterSet) -> (String) -> String {
    return { $0.remove(charactersIn: characterSet) }
}
