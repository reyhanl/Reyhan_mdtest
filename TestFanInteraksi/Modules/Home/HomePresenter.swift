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
    var filteredProfiles: [UserProfileModel] = []
    var profile: UserProfileModel?
    private var finishFetchingProfile: Bool = false
    private var finishFetchingProfiles: Bool = false
    var isSearching = false
    
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
    
    func search(_ text: String, filter: Filter){
        isSearching = text.count > 0 || filter != .none
        let filteredByEmails = listOfProfile.filter({$0.email?.contains(text) ?? false})
        let filteredByName = listOfProfile.filter({$0.name?.contains(text) ?? false})
        let set = Set(filteredByEmails)
        let union = set.union(filteredByName)
        if filter != .none{
            let filterRawValue = filter == .nonVerified ? false:true
            if text == ""{
                filteredProfiles = listOfProfile.filter({$0.isVerified == filterRawValue})
            }else{
                filteredProfiles = Array(union).filter({$0.isVerified == filterRawValue})
            }
        }else{
            filteredProfiles = Array(union)
        }
        print(filteredByName)
        view?.updateTableView()
    }
    
    func signOut() {
        interactor?.signOut()
    }
    
    func numberOfRows() -> Int {
        return isSearching ? filteredProfiles.count:listOfProfile.count
    }
    
    func profile(at index: Int) -> UserProfileModel {
        return isSearching ? filteredProfiles[index]:listOfProfile[index]
    }
    func getProfile() -> UserProfileModel? {
        return profile
    }
}
