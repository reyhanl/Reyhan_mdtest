//
//  AuthInteractor.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import Foundation
import FirebaseAuth

class AuthInteractor: AuthPresenterToInteractorProtocol{
    var presenter: AuthInteractorToPresenterProtocol?
    
    func updateUserData(token: String, email: String, id: String, isVerified: Bool) {
        NetworkManager.shared.setDocument(model: UserProfileModel(name: email.getEmailName(), id: id, profilePictureUrl: "", isVerified: isVerified, email: email), document: .user(id)) { [weak self] result in
            switch result {
            case .success(_):
                self?.presenter?.result(result: .success(.successfullyRegister(token)))
            case .failure(let failure):
                let customError: CustomError = .failedToSignIn(failure.localizedDescription)
                self?.presenter?.result(result: .failure(customError))
            }
        }
    }
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] auth, error in
            guard let self = self else{return}
            if let error = error{
                let customError: CustomError = .failedToSignUp(error.localizedDescription)
                presenter?.result(result: .failure(customError))
                
                return
            }
            let token = auth?.user.refreshToken ?? ""
            self.updateUserData(token: token, email: email, id: auth?.user.uid ?? "", isVerified: auth?.user.isEmailVerified ?? false)
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] auth, error in
            guard let self = self else{return}
            if let error = error{
                let customError: CustomError = .failedToSignIn(error.localizedDescription)
                presenter?.result(result: .failure(customError))
                return
            }
            let token = auth?.user.refreshToken ?? ""
            presenter?.result(result: .success(.successfullySignIn(token)))
        }
    }
    
    func saveToken(token: String) {
        UserDefaults.standard.setValue(token, forKey: "refreshToken")
    }
}
