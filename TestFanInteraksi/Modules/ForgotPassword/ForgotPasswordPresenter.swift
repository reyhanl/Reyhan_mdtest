//
//  ForgotPasswordPresenter.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import Foundation

class ForgotPasswordPresenter: ForgotPasswordPresenterProtocol{
    
    var router:  ForgotPasswordRouterProtocol?
    var view: ForgotPasswordViewProtocol?
    var interactor: ForgotPasswordInteractorProtocol?
    
    
    func viewDidLoad() {
        
    }
    
    func userClickForgotPassword(email: String) {
        interactor?.forgotPassword(email: email)
    }
    
    func result(error: (any Error)?) {
        if let error = error{
            view?.updateStatusLabel(text: error.localizedDescription, isError: true)
        }else{
            view?.updateStatusLabel(text: "Please check your email", isError: false)
        }
    }
}
