//
//  HomeRouter.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import UIKit

class HomeRouter: HomeRouterProtocol{
    static func makeComponent() -> HomeViewController {
        var presenter: HomePresenterProtocol = HomePresenter()
        let view = HomeViewController()
        var interactor: HomeInteractorProtocol = HomeInteractor()
        let router: HomeRouterProtocol = HomeRouter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}
