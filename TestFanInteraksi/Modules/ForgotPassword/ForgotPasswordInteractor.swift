//
//  ForgotPasswordInteractor.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import FirebaseAuth

class ForgotPasswordInteractor: ForgotPasswordInteractorProtocol{
    
    var presenter: ForgotPasswordPresenterProtocol?
    
    func forgotPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            self?.presenter?.result(error: error)
        }
    }
}
