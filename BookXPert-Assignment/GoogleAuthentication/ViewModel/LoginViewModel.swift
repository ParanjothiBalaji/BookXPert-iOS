//
//  LoginViewModel.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 19/06/25.
//

import Foundation
import Firebase
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    
    func signInWithGoogle(from vc: UIViewController) {
        FirebaseAuthManager.shared.signInWithGoogle(presentingVC: vc) { result in
            switch result {
            case .success(let user):
                print("Login success: \(user.email ?? "No name")")
                self.delegate?.didLoginSuccessfully()
                let user = UserDetails(name: user.displayName ?? "", email: user.email ?? "")
                CoreDataManager.shared.saveUserDetails(user)
            case .failure(let error):
                print("Login failed: \(error.localizedDescription)")
                self.delegate?.didFailToLogin(with: error)
                
            }
        }
    }
}
