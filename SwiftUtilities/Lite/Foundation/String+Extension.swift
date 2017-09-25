//
//  String+Extension.swift
//  SwiftUtilities
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
        return substring(with: range)
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
        return String(self[fromIndex...])
    }
    
    public func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    public func substring(with range: Range<Int>) -> String {
        let startIndex = index(from: range.lowerBound)
        let endIndex = index(from: range.upperBound)
        return String(self[startIndex..<endIndex])
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
        return Array(map({ "\($0)" })).take(numberOfElements).joined()
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
