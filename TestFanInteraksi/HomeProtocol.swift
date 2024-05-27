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
}

protocol HomePresenterProtocol{
    
    var interactor: HomeInteractorProtocol?{get set}
    var view: HomeViewProtocol?{get set}
    var router: HomeRouterProtocol?{get set}
    
    func viewDidLoad()
    func result(result: Result<HomeSuccessType, Error>)
    func numberOfRows() -> Int
    func getProfile() -> UserProfileModel
    func profile(at index: Int) -> UserProfileModel
}

protocol HomeInteractorProtocol{
    
    var presenter: HomePresenterProtocol?{get set}
    
    func fetchFetchUserData()
    func fetchUsersList()
}

enum HomeSuccessType{
    case successfullyFetchedProfile(UserProfileModel)
    case successfullyFetchedProfiles([UserProfileModel])
}

protocol HomeRouterProtocol{
    static func makeComponent() -> HomeViewController
}
