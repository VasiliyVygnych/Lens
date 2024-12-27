//
//  SceneDelegate.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 18.11.2024.
//

import UIKit

class SceneDelegate: UIResponder,
                        UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController()
        let coordinator: OnboardingCoordinatorProtocol = OnboardingCoordinator(navigationController: navigationController)
        coordinator.initial()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
