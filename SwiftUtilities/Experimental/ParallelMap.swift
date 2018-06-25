//
//  Collection+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 7/20/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

import Foundation

extension Collection {
    
    // crash on big size
    public func parallelMap_1<T>(_ transform: @escaping (Self.Iterator.Element) -> T) -> [T] {
        let indices = indicesArray()
        var result = [T?](repeating: nil, count: indices.count)
        
        let queue = OperationQueue()
        
        for (index, element) in enumerated() {
            queue.addOperation({
                result[index] = transform(element)
            })

            if index % 4 == 0 {
                queue.waitUntilAllOperationsAreFinished()
            }
        }
        queue.waitUntilAllOperationsAreFinished()
        
        return result.map({ $0! })
    }
    
    // crash on big size
    public func parallelMap_2<T>(_ transform: @escaping (Self.Iterator.Element) -> T) -> [T] {
        let indices = indicesArray()
        var result = [T?](repeating: nil, count: indices.count)
        
        let queue = OperationQueue()
        
        let operations = indices.enumerated().map({ index, elementIndex in
            return BlockOperation(block: {
                result[index] = transform(self[elementIndex])
            })
        })
        
        queue.addOperations(operations, waitUntilFinished: true)
        
        return result.map({ $0! })
    }
    
    // Slow on big size and small fib number
    public func parallelMap_3<T>(_ transform: @escaping (Self.Iterator.Element) -> T) -> [T] {
        let indices = indicesArray()
        let result = UnsafeMutablePointer<T>.allocate(capacity: indices.count)
        
        let queue = OperationQueue()
        
        let operations = indices.enumerated().map({ index, elementIndex in
            return BlockOperation(block: {
                result[index] = transform(self[elementIndex])
            })
        })
        
        queue.addOperations(operations, waitUntilFinished: true)
        
        let f = Array<T>(UnsafeBufferPointer(start: result, count: indices.count))
        result.deallocate()
        return f
    }
    
    // MARK: - Private
    
    private func indicesArray() -> [Self.Index] {
        var indicesArray: [Self.Index] = []
        var nextIndex = startIndex
        while nextIndex != endIndex {
            indicesArray.append(nextIndex)
            nextIndex = index(after: nextIndex)
        }
        return indicesArray
    }
    
}

extension Array {
    
    public func parallelMap2<T>(_ transform: @escaping (Element) -> T, completion: @escaping ([T]) -> Void) {
        var result = [T?](repeating: nil, count: count)
        
        result.withUnsafeMutableBufferPointer({ pointer in
            DispatchQueue.concurrentPerform(iterations: count, execute: { index in
                pointer[index] = transform(self[index])
            })
        })
        
        DispatchQueue.main.async(execute: {
            completion(result.map({ $0! }))
        })
    }
    
    public func parallelMap3<R>(striding n: Int, f: @escaping (Element) -> R, completion: @escaping ([R]) -> ()) {
        let N = count
        
        var finalResult = Array<R?>(repeating: nil, count: N)
        
        finalResult.withUnsafeMutableBufferPointer { res in
            DispatchQueue.concurrentPerform(iterations: N/n) { k in
                for i in (k * n)..<((k + 1) * n) {
                    res[i] = f(self[i])
                }
            }
        }
        
        for i in (N - (N % n))..<N {
            finalResult[i] = f(self[i])
        }
        
        DispatchQueue.main.async {
            completion(finalResult.map({ $0! }))
        }
    }
    
    public func parallelMap4<R>(striding n: Int, f: @escaping (Element) -> R) -> [R] {
        let N = count
        
        var finalResult = Array<R?>(repeating: nil, count: N)
        
        finalResult.withUnsafeMutableBufferPointer { res in
            DispatchQueue.concurrentPerform(iterations: N/n) { k in
                for i in (k * n)..<((k + 1) * n) {
                    res[i] = f(self[i])
                }
            }
        }
        
        for i in (N - (N % n))..<N {
            finalResult[i] = f(self[i])
        }
        
        return finalResult.map({ $0! })
    }
    
    public func parallelMap5<R>(striding n: Int, f: @escaping (Element) -> R) -> [R] {
        let N = count
        
        var finalResult = Array<R?>(repeating: nil, count: N)
        
        finalResult.withUnsafeMutableBufferPointer { res in
            let iterations = 1000
            
            DispatchQueue.concurrentPerform(iterations: iterations, execute: { k in
                let start = N / iterations * k
                let end = N / iterations * (k + 1) - 1
                let result = self[start...end].map(f)
                
                for (index, element) in result.enumerated() {
                    res[start + index] = element
                }
            })
        }
        
        return finalResult.map({ $0! })
    }
    
    public func parallelMap<T>(_ transform: @escaping (Element) -> T) -> [T] {
        var finalResult = Array<T?>(repeating: nil, count: count)
        
        finalResult.withUnsafeMutableBufferPointer { res in
            DispatchQueue.concurrentPerform(iterations: count, execute: { i in
                res[i] = transform(self[i])
            })
        }
        
        return finalResult.map({ $0! })
    }
    
}



func fibonacci(_ n: Int) -> Int {
    if n == 0 || n == 1 {
        return n
    }
    return fibonacci(n - 1) + fibonacci(n - 2)
}
//
//import XCTest
//
//class IterationTests: XCTestCase {
//
//    func testParallel() {
//        let size = 10000
//        let fibNumber = 20
//
//        var result1 = [Int](repeating: 0, count: size)
//        let operations = (1...size).map({ i in
//            return BlockOperation(block: {
//                result1[i - 1] = fibonacci(fibNumber)
//            })
//        })
//        let t1 = Date()
//        OperationQueue().addOperations(operations, waitUntilFinished: true)
//        let delta1 = -t1.timeIntervalSinceNow
//        print("delta1: \(delta1)")
//
//        let t2 = Date()
//        let result2 = (1...size).map({ _ in fibonacci(fibNumber) })
//        let delta2 = -t2.timeIntervalSinceNow
//        print("delta2: \(delta2)")
//
//        let t3 = Date()
//        let result3 = (1...size).parallelMap({ _ in fibonacci(fibNumber) })
//        let delta3 = -t3.timeIntervalSinceNow
//        print("delta3: \(delta3)")
//
//
//        print("proportion: \(delta2 / delta1)")
//
//        print("")
//    }
//
//    func testBigCombinations() {
//        let size = 6
//        let options = (1...size).map({ _ in (1...10).map({ $0 }) })
//
//        var expectedCombinations = [[Int]]()
//        for x1 in (1...10) {
//            for x2 in (1...10) {
//                for x3 in (1...10) {
//                    for x4 in (1...10) {
//                        for x5 in (1...10) {
//                            for x6 in (1...10) {
//                                expectedCombinations.append([x1, x2, x3, x4, x5, x6])
//                            }}}}}}
//
//        let t1 = Date()
//
//        combinations(options: options).forEach({ i in
//            let x = 2
//        })
//
//        print(t1.timeIntervalSinceNow)
//        let t2 = Date()
//
//        combinations2(options: options).forEach({ i in
//            let x = 2
//        })
//
//        print(t2.timeIntervalSinceNow)
//        let t3 = Date()
//
//        Combinations(options: options).forEach({ i in
//            let x = 2
//        })
//
//        print(t3.timeIntervalSinceNow)
//
//
//
//        let actualCombinations = combinations(options: options)
//
//        //        XCTAssertEqual(actualCombinations.count, IntMax(expectedCombinations.count))
//
//        zip(actualCombinations, expectedCombinations).forEach({ (combination, expectedCombination) in
//            XCTAssertEqual(combination, expectedCombination)
//        })
//    }
//
//    func testCombinations() {
//        let actualCombinations = Array(combinations2(options: input))
//
//        XCTAssertEqual(actualCombinations.count, expectedCombinations.count)
//
//        zip(actualCombinations, expectedCombinations).forEach({ (combination, expectedCombination) in
//            XCTAssertEqual(combination, expectedCombination)
//        })
//    }
//
//    // MARK: - Private
//
//    private let input = [
//        [1, 2],
//        [3, 4],
//        [5, 6]
//    ]
//
//    private let expectedCombinations = [
//        [1, 3, 5],
//        [1, 3, 6],
//        [1, 4, 5],
//        [1, 4, 6],
//        [2, 3, 5],
//        [2, 3, 6],
//        [2, 4, 5],
//        [2, 4, 6]
//    ]
//
//}

