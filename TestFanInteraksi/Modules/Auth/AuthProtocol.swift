//
//  AuthProtocol.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import Foundation
import UIKit

protocol AuthPresenterToViewProtocol{
    var presenter: AuthViewToPresenterProtocol? {get set}
    func presentBubbleAlert(text: String, with duration: CGFloat, floatingDuration: CGFloat)
}

protocol AuthViewToPresenterProtocol{
    var view: AuthPresenterToViewProtocol? {get set}
    var router: AuthPresenterToRouterProtocol? {get set}
    func register(name: String, email: String, password: String)
    func signIn(email: String, password: String)
    func goToSignIn(from vc: UIViewController)
    func goToSignUp(from vc: UIViewController)
    func goToForgotPassword(from vc: UIViewController)
//    func purchase(motorcycle: Register)
}

protocol AuthPresenterToInteractorProtocol{
    var presenter: AuthInteractorToPresenterProtocol? {get set}
    func register(name: String, email: String, password: String)
    func signIn(email: String, password: String)
    func saveToken(token: String)
//    func purchase(motorcycle: Register)
}


protocol AuthInteractorToPresenterProtocol{
    var interactor: AuthPresenterToInteractorProtocol? {get set}
    func result(result: Result<AuthSuccessType, Error>)
}

protocol AuthPresenterToRouterProtocol{
    static func makeComponent(for type: AuthType) -> AuthViewController
    func goToSignIn(from vc: UIViewController)
    func goToSignUp(from vc: UIViewController)
    func goToForgotPassword(from vc: UIViewController)
}

enum AuthSuccessType{
    case successfullyRegister(String)
    case successfullySignIn(String)
    case successfullySentEmailVerification
}

enum AuthType{
    case signIn
    case signUp
}
