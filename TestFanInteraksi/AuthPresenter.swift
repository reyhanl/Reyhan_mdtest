//
//  AuthPresenter.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import Foundation
import UIKit

class AuthPresenter: AuthViewToPresenterProtocol{
    var view: AuthPresenterToViewProtocol?
    var interactor: AuthPresenterToInteractorProtocol?
    var router: AuthPresenterToRouterProtocol?
    
    func register(name: String, email: String, password: String) {
        interactor?.register(name: name, email: email, password: password)
    }
    
    func signIn(email: String, password: String) {
        interactor?.signIn(email: email, password: password)
    }
    
    func goToSignIn(from vc: UIViewController) {
        router?.goToSignIn(from: vc)
    }
    
    func goToSignUp(from vc: UIViewController) {
        router?.goToSignUp(from: vc)
    }
    
    func goToForgotPassword(from vc: UIViewController) {
        router?.goToForgotPassword(from: vc)
    }

}

extension AuthPresenter: AuthInteractorToPresenterProtocol{
    
    func result(result: Result<AuthSuccessType, Error>) {
        switch result{
        case .success(let type):
            handleSuccess(type: type)
        case .failure(let error):
            handleError(error)
        }
    }
    
    func handleSuccess(type: AuthSuccessType){
        switch type {
        case .successfullyRegister(let refreshToken), .successfullySignIn(let refreshToken):
            interactor?.saveToken(token: refreshToken)
        case .successfullySentEmailVerification:
            view?.presentBubbleAlert(text: "We've sent you a verification email", with: 0.3, floatingDuration: 1)
        }
        //Scene delegate / AuthListener will automatically get user to HomeVC
    }
    
    func handleError(_ error: Error){
        if let error = error as? CustomError{
            switch error{
            case .failedToSignIn(let localizedDescription), .failedToSignUp(let localizedDescription):
                view?.presentBubbleAlert(text: localizedDescription, with: 0.5, floatingDuration: 1)
                break
            default:
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
