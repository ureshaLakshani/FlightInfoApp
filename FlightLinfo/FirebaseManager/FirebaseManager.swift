//
//  FirebaseManager.swift
//  FlightLinfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import FirebaseAuth

class FirebaseManager{
    
    static let shared = FirebaseManager()
    
    //MARK: - SignUP
    func createUser(email: String, password: String, completion: @escaping CompletionHandler) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completion(true, 200, "Success")
            } else {
                completion(false, 123, error.debugDescription)
            }
        }
    }
    
    //MARK: - SignIn
    func signIn(email: String, pass: String, completion: @escaping CompletionHandler) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completion(false, error._code, error.localizedDescription)
            } else {
                completion(true, 200, "Success")
            }
        }
    }
    
    func logOut(){
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
    }
}

