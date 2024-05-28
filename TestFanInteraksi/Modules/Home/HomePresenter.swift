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
    private var finishFetchingProfile: Bool = false
    private var finishFetchingProfiles: Bool = false
    
    func viewDidLoad(){
        finishFetchingProfile = false
        finishFetchingProfiles = false
        interactor?.fetchData()
    }
    
    func userRefreshData(){
        finishFetchingProfile = false
        finishFetchingProfiles = false
        interactor?.fetchData()
    }
    
    func result(result: Result<HomeSuccessType, Error>){
        switch result{
        case .success(let type):
            handleSuccess(type: type)
        case .failure(let error):
            handleError(error: error)
        }
        if finishFetchingProfile && finishFetchingProfiles{
            view?.stopRefreshControl()
        }
    }
    
    func handleSuccess(type: HomeSuccessType){
        switch type{
        case .successfullyFetchedProfile(let profile):
            self.profile = profile
            finishFetchingProfile = true
            view?.updateTableView()
        case .successfullyFetchedProfiles(let profiles):
            self.listOfProfile = profiles
            finishFetchingProfiles = true
            view?.updateTableView()
            break
        }
    }
    
    func handleError(error: Error){
        switch error{
        case CustomError.failedToFetchProfile:
            finishFetchingProfile = true
        case CustomError.failedToFetchProfiles:
            finishFetchingProfiles = true
        default:
            print("error: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        interactor?.signOut()
    }
    
    func numberOfRows() -> Int {
        return listOfProfile.count
    }
    
    func profile(at index: Int) -> UserProfileModel {
        return listOfProfile[index]
    }
    func getProfile() -> UserProfileModel? {
        return profile
    }
}
