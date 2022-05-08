//
//  MainRouter.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import UIKit

final class MainRouter {

    // MARK: - Private Properties

    private var viewController: UIViewController

    // MARK: - Initialization

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

}

extension MainRouter: MainRouterInput {

    func showAdd() {
        let addVC = AddConfigurator().configureModule()
        viewController.navigationController?.pushViewController(addVC, animated: true)
    }
}
