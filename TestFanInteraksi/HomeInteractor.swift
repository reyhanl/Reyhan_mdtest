//
//  HomeInteractor.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import Foundation
import FirebaseAuth

class HomeInteractor: HomeInteractorProtocol{
    
    var presenter: HomePresenterProtocol?
    
    func fetchUsersList() {
        //fetch using a custom server that implements FirebaseAdmin
        presenter?.result(result: .failure(CustomError.failedToFetchProfiles))
    }
    
    func fetchFetchUserData() {
        NetworkManager.shared.fetchProfile { result in
            switch result{
            case .success(let profile):
                self.presenter?.result(result: .success(.successfullyFetchedProfile(profile)))
            case .failure(let error):
                self.presenter?.result(result: .failure(CustomError.failedToFetchProfile))
            }
        }
    }
}
