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
        users.append(User(image: "Jimmy Kimmel", first: "Jimmy", last: "Kimmel"))
        print("repo")
        
        return users
    }
}
