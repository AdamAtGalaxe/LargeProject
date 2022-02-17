//
//  UserRepo.swift
//  AdamProject
//
//  Created by Adam Roberts on 2/4/22.
//

import Foundation
class UserRepo{
    
    func getUsers()->[User]{
        var users = [User]()
        users.append(User(image: "Jimmy Mamba", first: "Joe", last: "Mamba", myEmail: ""))
        return users
    }
}
