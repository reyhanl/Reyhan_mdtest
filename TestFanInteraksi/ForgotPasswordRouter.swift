//
//  ForgotPasswordRouter.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import Foundation
import UIKit

class ForgotPasswordRouter: ForgotPasswordRouterProtocol{
    
    static func makeComponent() -> ForgotPasswordViewController {
        var presenter: ForgotPasswordPresenterProtocol = ForgotPasswordPresenter()
        let view = ForgotPasswordViewController()
        var interactor: ForgotPasswordInteractorProtocol = ForgotPasswordInteractor()
        let router: ForgotPasswordRouterProtocol = ForgotPasswordRouter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
    func gotToAuthVC(with vc: UIViewController) {
        
    }
}
