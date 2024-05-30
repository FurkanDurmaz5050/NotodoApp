//
//  AuthManager.swift
//  MyToDoList
//
//  Created by Kodgem Technology on 7.02.2022.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthManager: ObservableObject {
    let db: Firestore = Firestore.firestore()
    let auth = Auth.auth()
    
    @Published var errorResetPasswordText = ""

    
    
    func resetPassword(email:String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
          // ...
            if let error = error{
                self.errorResetPasswordText = error.localizedDescription
            }
            
        }
    }
    
    func isUserSignIn() -> (Bool, String)
    {
        var result:Bool = false
        var userID:String = ""
        if Auth.auth().currentUser != nil {
          // Kullanıcı bilgileri alınacak ve ana sayfaya gidilecek
            let user = Auth.auth().currentUser
            if let user = user {
              let uid = user.uid
                result = true
                userID = user.uid
            }
            
        } else {
          // Login sayfasına gidilecek
            result = false
            userID = ""
        }
        
        return (result, userID)
        
    }
    
    func logoutFB() {
        // call from any screen
        
        do {
            try Auth.auth().signOut()

            
            
        }
        catch {
            print("already logged out")
            
        }
        
    }
    
    func deleteAccount(){
        Auth.auth().currentUser!.delete { error in
                 if let error = error {
                     print("error deleting user - \(error)")
                 } else {
                     print("Account deleted")
                 }
             }
    }
    
}
