//
//  User.swift
//  DatingApp
//
//  Created by BookMAc on 8/28/21.
//

import UIKit

struct User {
    var name: String
    var age: Int
    var email: String
    let uid: String
    let profileImageUrl: String
    //var images: [UIImage]
    
    ///look in the dictionary of the  database and verify
    init(dictionary: [String: Any])  {
        self.name = dictionary["fullname"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["imageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
