//
//  User.swift
//  AdamProject
//
//  Created by Adam Roberts on 2/4/22.
//

import Foundation
class User : Decodable
{
    var id: Int?
    var first_name: String
    var last_name: String
    var avatar: String
    var email: String
    var photo: Data?
    
    init(image: String, first: String, last: String){
        first_name = first
        last_name = last
        avatar = image
        email = "\(first.prefix(1))\(last)@galaxe.com"
        id = nil
    }
    enum CodingKeys: String, CodingKey{
        case id
        case email
        case first_name = "first_name"
        case last_name = "last_name"
        case avatar = "avatar"
    }

}
class Result: Decodable{
    let total: Int
    let data: [User]
    
}

