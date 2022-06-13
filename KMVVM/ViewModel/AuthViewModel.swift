//
//  AuthViewModel.swift
//  KMVVM
//
//  Created by sahib-dev on 6/13/22.
//

import Foundation

protocol FirebaseAuthViewModelDelegate: AnyObject {
    func login()
    func register()
    func error(error: String, sign: Bool)
}

class AuthViewModel {
    
    let firebaseViewModel: FirebaseViewModel = FirebaseViewModel()
    var authViewControllerDelegate: AuthViewControllerDelegate?
    var firebaseAuthViewModelDelegate: FirebaseAuthViewModelDelegate?
    
    init() {
        self.authViewControllerDelegate = self
    }
    
}

extension AuthViewModel: AuthViewControllerDelegate {
    
    func buttonClicked(tag: Int, email: String?, password: String?) {
        switch tag {
        case 0:
            self.firebaseViewModel.signUser(email: email, password: password, completion: {
                self.firebaseAuthViewModelDelegate?.login()
            }, failure: { (error) in
                self.firebaseAuthViewModelDelegate?.error(error: error, sign: true)
            })
            break
        case 1:
            self.firebaseViewModel.registerUser(email: email, password: password, completion: {
                self.firebaseAuthViewModelDelegate?.register()
            }, failure: { (error) in
                self.firebaseAuthViewModelDelegate?.error(error: error, sign: false)
            })
            break
        default:
            break
        }
    }
}
