//
//  FirebaseCloudFirestore.swift
//  KMVVM
//
//  Created by sahib-dev on 6/13/22.
//

import Foundation
import Firebase
import CodableFirebase

class FirebaseCloudFirestoreManager {
    
    init() {
        
    }
    
    // ... users
    func setUser(userArray: [String], completion: @escaping(() -> Void), failure: @escaping((_ error: String) -> Void)){
        var arrayU: [String] = userArray
        self.getUsers(completion: { (arrayUsers) in
            arrayU.append(contentsOf: arrayUsers)
            self.setArrayUser(arrayUser: Array(Set(arrayU)), completion: {
                completion()
            }, failure: {(error) in
                failure(error)
            })
        }) { (error) in
            self.setArrayUser(arrayUser: Array(Set(arrayU)), completion: {
                completion()
            }, failure: {(error) in
                failure(error)
            })
        }
    }
    
    private func setArrayUser(arrayUser: [String], completion: @escaping(() -> Void), failure: @escaping((_ error: String) -> Void)){
        Firestore.firestore().collection("users").document("users").setData(["users": arrayUser]) { (error) in
            if let error = error{
                failure(error.localizedDescription)
            } else {
                completion()
            }
        }
    }
    
    private func getUsers(completion: @escaping((_ arrayUsers: [String]) -> Void), failure: @escaping((_ error: String) -> Void)){
        Firestore.firestore().collection("users").document("users").getDocument(completion: { (documentSnapshot, error) in
            if let error = error {
                failure(error.localizedDescription)
            } else{
                if let documentSnapshot = documentSnapshot, documentSnapshot.exists {
                    do {
                        completion(try FirebaseDecoder().decode([String].self, from: documentSnapshot.data()?["users"] as Any))
                    } catch {
                        failure(error.localizedDescription)
                    }
                } else {
                    failure("")
                }
                
            }
        })
    }
    
    func updateUser(completion: @escaping((_ users: [String]) -> Void), failure: @escaping((_ error: String) -> Void)){
        Firestore.firestore().collection("users").document("users").addSnapshotListener { (documentSnapshot, error) in
            if let error = error {
                failure(error.localizedDescription)
            } else {
                if let documentSnapshot = documentSnapshot, documentSnapshot.exists {
                    do {
                        completion(try FirebaseDecoder().decode([String].self, from: documentSnapshot.data()?["users"] as Any))
                    } catch {
                        failure(error.localizedDescription)
                    }
                } else {
                    failure("")
                }
            }
        }
    } // ... users
    
    
}
