//
//  HomeProtocol.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import Foundation

protocol HomeViewProtocol{
    
    var presenter: HomePresenterProtocol?{get set}
    
    func updateTableView()
    func updateProfileData()
    func stopRefreshControl()
}

protocol HomePresenterProtocol{
    
    var interactor: HomeInteractorProtocol?{get set}
    var view: HomeViewProtocol?{get set}
    var router: HomeRouterProtocol?{get set}
    
    func viewDidLoad()
    func userRefreshData()
    func result(result: Result<HomeSuccessType, Error>)
    func numberOfRows() -> Int
    func getProfile() -> UserProfileModel?
    func search(_ text: String, filter: Filter)
    func profile(at index: Int) -> UserProfileModel
    func signOut()
}

protocol HomeInteractorProtocol{
    
    var presenter: HomePresenterProtocol?{get set}
    
    func fetchData()
    func signOut()
}

enum HomeSuccessType{
    case successfullyFetchedProfile(UserProfileModel)
    case successfullyFetchedProfiles([UserProfileModel])
}

protocol HomeRouterProtocol{
    static func makeComponent() -> HomeViewController
}
