//
//  MainConfigurator.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import UIKit

final class MainConfigurator {

    func configureModule() -> UIViewController {

        
        let viewController = MainViewController(nibName: "MainViewController", bundle: nil)
        let router = MainRouter(viewController: viewController)
        let presenter = MainPresenter()
        let interactor = MainInteractor()
        
        presenter.router = router
        presenter.view = viewController
        presenter.interactor = interactor
        
        viewController.output = presenter
        
        interactor.output = presenter
        
        return viewController
    }
    
}
