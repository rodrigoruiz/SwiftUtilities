//
//  MFMailComposeViewController+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

import MessageUI


public typealias MFMailComposeDelegateCallback = (
    _ controller: MFMailComposeViewController,
    _ result: MFMailComposeResult,
    _ error: Swift.Error?
) -> Void

public class MFMailComposeDelegate: NSObject, MFMailComposeViewControllerDelegate {
    
    public let callback: MFMailComposeDelegateCallback
    
    public init(callback: @escaping MFMailComposeDelegateCallback) {
        self.callback = callback
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    
    public func mailComposeController(
        _ controller: MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: Swift.Error?
    ) {
        callback(controller, result, error)
        delegateCallbacks[controller] = nil
    }
    
}

extension MFMailComposeViewController {
    
    public func setDelegate(callback: @escaping MFMailComposeDelegateCallback) {
        delegateCallbacks[self] = MFMailComposeDelegate(callback: callback)
        mailComposeDelegate = delegateCallbacks[self]
    }
    
}

// MARK: - Private

private var delegateCallbacks = [MFMailComposeViewController: MFMailComposeDelegate]()
