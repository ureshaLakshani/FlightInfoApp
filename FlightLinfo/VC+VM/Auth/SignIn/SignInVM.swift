//
//  SignInVM.swift
//  FlightLinfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import Foundation

class SignInVM{
    
    //Validate Email address with Regex
    func validateEmailAddress(email: String) -> Bool{
        let result = email.range(
            of: ValidationPatterns.shared.emailPattern,
            options: .regularExpression
        )
        
        let validEmail = (result != nil)
        return validEmail
    }
    
    //Validate Password with Regex
    func validatePasswordField(password: String) -> Bool{
        let result = password.range(
            of: ValidationPatterns.shared.passwordPattern,
            options: .regularExpression
        )

        let validPassword = (result != nil)
        return validPassword
    }
    
    func signInWithFirebaseUser(email: String, password: String, completion: @escaping CompletionHandler){
        FirebaseManager.shared.signIn(email: email, pass: password) { status, code, message in
            completion(status, code, message)
        }
    }
    
}
