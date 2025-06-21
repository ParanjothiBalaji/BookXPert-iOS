//
//  FirebaseAuthManager.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 19/06/25.
//

import FirebaseAuth
import GoogleSignIn
import FirebaseCore

class FirebaseAuthManager {

    static let shared = FirebaseAuthManager()

    private init() {}

    func signInWithGoogle(presentingVC: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(NSError(domain: "FirebaseError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Missing Client ID"])))
            return
        }

        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { signInResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let result = signInResult else {
                completion(.failure(NSError(domain: "SignInError", code: 2, userInfo: [NSLocalizedDescriptionKey: "No result from Google Sign-In"])))
                return
            }

            let user = result.user

            guard let idToken = user.idToken?.tokenString else {
                completion(.failure(NSError(domain: "TokenError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Missing ID Token"])))
                return
            }

            let accessToken = user.accessToken.tokenString

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    completion(.failure(error))
                } else if let user = result?.user {
                    completion(.success(user))
                }
            }
        }
    }

}
