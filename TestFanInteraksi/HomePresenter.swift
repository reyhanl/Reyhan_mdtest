//
//  HomePresenter.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import Foundation

class HomePresenter: HomePresenterProtocol{
    
    var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    
    var listOfProfile: [UserProfileModel] = []
    var profile: UserProfileModel?
    
    func viewDidLoad(){
        interactor?.fetchFetchUserData()
        interactor?.fetchUsersList()
    }
    
    func result(result: Result<HomeSuccessType, Error>){
        switch result{
        case .success(let type):
            handleSuccess(type: type)
        case .failure(let error):
            handleError(error: error)
        }
    }
    
    func handleSuccess(type: HomeSuccessType){
        switch type{
        case .successfullyFetchedProfile(let profile):
            break
        case .successfullyFetchedProfiles(let profiles):
            break
        }
    }
    
    func handleError(error: Error){
        
    }
    
    func numberOfRows() -> Int {
        return listOfProfile.count
    }
    
    func profile(at index: Int) -> UserProfileModel {
        return listOfProfile[index]
    }
    func getProfile() -> UserProfileModel {
        return .init()
    }
}
