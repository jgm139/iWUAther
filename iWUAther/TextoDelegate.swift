//
//  TextoDelegate.swift
//  iWUAther
//
//  Created by Máster Móviles on 24/10/2019.
//  Copyright © 2019 Máster Móviles. All rights reserved.
//

import UIKit

class TextoDelegate: NSObject, UITextFieldDelegate {
    
    //MARK: Functions
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let input = Int(string) {
         return false
        }
        
        return true
    }
}
