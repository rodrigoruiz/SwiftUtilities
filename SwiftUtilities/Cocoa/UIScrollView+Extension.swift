//
//  UIScrollView+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

// extension UIScrollView {
//     
//     public func scrollToTop(animated: Bool = false) {
//         var contentOffset = self.contentOffset
//         contentOffset.y = 0
//         setContentOffset(contentOffset, animated: animated)
//     }
//     
//     public func scrollToBottom(animated: Bool = false) {
//         var contentOffset = self.contentOffset
//         
//         contentOffset.y = contentSize.height - bounds.size.height
//         
//         if contentOffset.y < 0 {
//             contentOffset.y = 0
//         }
//         
//         setContentOffset(contentOffset, animated: animated)
//     }
//     
//     public func addToContentOffset(x: CGFloat, y: CGFloat, animated: Bool = false) {
//         var contentOffset = self.contentOffset
//         contentOffset.x += x
//         contentOffset.y += y
//         setContentOffset(contentOffset, animated: animated)
//     }
//     
//     public func setContentOffset(x: CGFloat? = nil, y: CGFloat? = nil, animated: Bool = false) {
//         var contentOffset = self.contentOffset
//         
//         if let x = x {
//             contentOffset.x = x
//         }
//         if let y = y {
//             contentOffset.y = y
//         }
//         
//         setContentOffset(contentOffset, animated: animated)
//     }
//     
//     public func currentPage() -> Int {
//         if !isPagingEnabled {
//             fatalError("Paging not enabled.")
//         }
//         
//         return Int(contentOffset.x / frame.width)
//     }
//     
//     public func moveToPage(_ page: Int, animated: Bool = false, completion: @escaping () -> Void = {}) {
//         if !isPagingEnabled {
//             fatalError("Paging not enabled.")
//         }
//         
//         let x = CGFloat(page) * frame.size.width
//         
//         if !animated {
//             setContentOffset(x: x)
//             completion()
//             return
//         }
//         
//         // TODO: implement a proper completion handler
//         // Maybe subclassing UIScrollView and making it be it's own delegate
//         
//         Timer.scheduledTimer(withTimeInterval: 0.31, repeats: false) { _ in
//             completion()
//         }
//         
//         setContentOffset(x: x, animated: animated)
//     }
//     
// }
