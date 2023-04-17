//
//  String+Ex.swift
//  Login
//
//  Created by Елизавета Ефросинина on 11/04/2023.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func match(_ regex: String) -> Bool {
        return range(of: regex, options: .regularExpression) != nil
    }
}
