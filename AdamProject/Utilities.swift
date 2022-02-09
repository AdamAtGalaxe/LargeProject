//
//  Utilities.swift
//  AdamProject
//
//  Created by Adam Roberts on 2/9/22.
//

import Foundation
class Utilities{
    
    class func isNetworkAvailable() -> Bool{
        return (Reachability.init(hostname: "\(BASE_URL)")?.isReachable)!
        //return (Reachability.init(hostname: BASE_URL)?.isReachable)!
    }
}

