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
    
    func fetchData() {
        //fetch using a custom server that implements FirebaseAdmin
        var usersModel: [UserDefaultModel] = []
        var users: [UserProfileModel] = []
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        SessionManager.shared.request(req: RequestEnum.fetchUsers, data: nil, queryItems: []) { (result: Result<[UserDefaultModel], Error>) in
            switch result {
            case .success(let users):
                usersModel = users
            case .failure(let failure):
                print(failure.localizedDescription)
                self.presenter?.result(result: .failure(CustomError.failedToFetchProfiles))
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        NetworkManager.shared.fetchCollection(reference: .users) { (result: Result<[UserProfileModel], Error>) in
            switch result {
            case .success(let tempUsers):
                users = tempUsers
            case .failure(let failure):
                self.presenter?.result(result: .failure(CustomError.failedToFetchProfiles))
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            var tempUser: UserProfileModel?
            for user in users{
                let isEmailVerified = usersModel.first(where: {$0.email.lowercased() == user.email?.lowercased()})?.emailVerified
                let email = Auth.auth().currentUser?.email ?? ""
                if user.email?.lowercased() == email.lowercased(){
                    tempUser = user
                }
                user.isVerified = isEmailVerified ?? false
            }
            print(users)
            self.presenter?.result(result: .success(.successfullyFetchedProfiles(users)))
            if let user = tempUser{
                self.presenter?.result(result: .success(.successfullyFetchedProfile(user)))
            }
        }
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
        }catch{
            presenter?.result(result: .failure(error))
        }
    }
}
