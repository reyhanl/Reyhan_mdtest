//
//  SceneDelegate.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var firstOpen: Bool = true

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
//        try? Auth.auth().signOut()    
        addAuthStateListener(scene: windowScene)
        redirectUser(scene: windowScene)
    }
    
    func addAuthStateListener(scene: UIWindowScene){
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AuthStateDidChange, object: Auth.auth(), queue: nil) { _ in
            self.redirectUser(scene: scene)
        }
    }
    
    func redirectUser(scene: UIWindowScene){
//        goToHome(scene: scene)
        if let user = Auth.auth().currentUser{
            NetworkManager.shared.fetchDocument(reference: .user(user.uid)) { (result: Result<UserProfileModel, Error>) in
                switch result{
                case .success(let user):
                    UserDefaultHelper.shared.storeProfile(user)
                case .failure(let error):
                    break
                }
                self.goToHome(scene: scene)
            }
        }else{
            if self.firstOpen{
                self.goToRegister(scene: scene)
            }else{
//                self.presentSignInInvalid(scene: scene)
            }
        }
        self.firstOpen = false
    }
    
    func goToRegister(scene: UIWindowScene){
        let vc = AuthRouter.makeComponent(for: .signUp)
        let navigationController = CustomNavigationController(rootViewController: vc)
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func goToHome(scene: UIWindowScene){
        let vc = HomeRouter.makeComponent()
        let navigationController = CustomNavigationController(rootViewController: vc)
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

