//
//  FirebaseViewModel.swift
//  KMVVM
//
//  Created by sahib-dev on 6/13/22.
//

import Firebase
import MMProgressHUD

class FirebaseViewModel {
    
    let firebaseAuthManager: FirebaseAuthManager = FirebaseAuthManager()
    let firebaseCloudFirestoreManager: FirebaseCloudFirestoreManager = FirebaseCloudFirestoreManager()

    init() {
        
    }
    
    // ... Firebase Auth
    func signUser(email: String?, password: String?, completion: @escaping(() -> Void), failure: @escaping((_ error: String) -> Void)){
        firebaseAuthManager.sign(email: email, password: password) { (authResult, error) in
            if let error = error {
                failure(error.localizedDescription)
            } else {
                completion()
            }
        }
    }
    
    func registerUser(email: String?, password: String?, completion: @escaping(() -> Void), failure: @escaping((_ error: String) -> Void)){
        firebaseAuthManager.register(email: email, password: password) { (authResult, error) in
            if let authResult = authResult, let emailString = authResult.user.email{
                // ... in user profile page, we can update user's profile with User model
                // adding names, bio, etc
                print("### Success ###")
                completion()
            } else {
                if let error: Error = error{
                    failure(error.localizedDescription)
                }
                print("### Failed")
            }
        }
    }
    
    func logoutUser(){
        MMProgressHUD.show()
        firebaseAuthManager.signOut(completion: {
            MMProgressHUD.dismiss()
        }) { (error) in
            MMProgressHUD.dismissWithError(error)
        }
    } // ... Firebase Auth
}

