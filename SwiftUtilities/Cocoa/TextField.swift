//
//  TextField.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 8/6/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public class TextField: UITextField, UITextFieldDelegate {
    
    var shouldChangeText: ((String) -> Bool)?
    var shouldReturn: (() -> Bool)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    // MARK: - UITextFieldDelegate
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let shouldChangeText = shouldChangeText else {
            return true
        }
        
        let currentText = (textField.text ?? "") as NSString
        let newText = currentText.replacingCharacters(in: range, with: string)
        
        return shouldChangeText(newText)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return shouldReturn?() ?? true
    }
    
}
