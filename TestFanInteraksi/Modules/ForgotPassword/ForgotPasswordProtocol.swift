//
//  ForgotPasswordProtocol.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import Foundation
import UIKit

protocol ForgotPasswordViewProtocol{
    var presenter: ForgotPasswordPresenterProtocol?{get set}
    
    func updateStatusLabel(text: String, isError: Bool)
}

protocol ForgotPasswordPresenterProtocol{
    var interactor: ForgotPasswordInteractorProtocol?{get set}
    var view: ForgotPasswordViewProtocol?{get set}
    var router: ForgotPasswordRouterProtocol?{get set}
    func viewDidLoad()
    func userClickForgotPassword(email: String)
    func result(error: Error?)
}

protocol ForgotPasswordInteractorProtocol{
    var presenter: ForgotPasswordPresenterProtocol?{get set}
    func forgotPassword(email: String)
}

protocol ForgotPasswordRouterProtocol{
    static func makeComponent() -> ForgotPasswordViewController
    func gotToAuthVC(with vc: UIViewController)
}
