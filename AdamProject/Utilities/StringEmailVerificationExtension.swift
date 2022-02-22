//
//  StringEmailVerificationExtension.swift
//  AdamProject
//
//  Created by Adam Roberts on 2/21/22.
//

import Foundation
extension String {
    
    var isValidEmail: Bool {
        
        guard !self.isEmpty else {
            return false
        }
        
        let entireRange = NSRange(location: 0, length: self.count)
        
        let types: NSTextCheckingResult.CheckingType = [.link]

        guard let detector = try? NSDataDetector(types: types.rawValue) else {
            return false
        }
        
        let matches = detector.matches(in: self, options: [], range: entireRange)
        
        guard matches.count == 1 else {
            return false
        }
        
        guard let result = matches.first else {
            return false
        }
        
        guard result.resultType == .link else {
            return false
        }
        
        guard result.url?.scheme == "mailto" else {
            return false
        }
        
        guard NSEqualRanges(result.range, entireRange) else {
            return false
        }
        
        if self.hasPrefix("mailto:") {
            return false
        }

        return true
    }
    
}
