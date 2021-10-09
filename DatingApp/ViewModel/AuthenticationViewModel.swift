//
//  AuthenticationViewModel.swift
//  DatingApp
//
//  Created by BookMAc on 10/09/2021.
//

import Foundation

protocol AuthenticationViewModel {
    var  formIsValid: Bool {get}
}

struct LoginViewModel: AuthenticationViewModel {
    /// als er waarde is in de textfield zet voort
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false &&
            password?.isEmpty == false
    }
}

struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var fullname: String?
    var password: String?
    
    var formIsValid: Bool {
        return  email?.isEmpty == false &&
            password?.isEmpty == false &&
        fullname?.isEmpty == false
                
    }
}
