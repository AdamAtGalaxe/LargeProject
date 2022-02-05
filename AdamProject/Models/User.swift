//
//  User.swift
//  AdamProject
//
//  Created by Adam Roberts on 2/4/22.
//

import Foundation
class User
{
    var userFirstName: String
    var userLastName: String
    var userAvatar: String
    var userEmail: String
    
    init(image: String, first: String, last: String){
        userFirstName = first
        userLastName = last
        userAvatar = image
        userEmail = "\(first.prefix(1))\(last)@galaxe.com"
    }

}
