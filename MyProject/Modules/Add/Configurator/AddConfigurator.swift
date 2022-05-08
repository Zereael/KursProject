//
//  AddConfigurator.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import UIKit

final class AddConfigurator {

    func configureModule() -> UIViewController {

        let viewController = AddViewController(nibName: "AddViewController", bundle: nil)
        let router = AddRouter(viewController: viewController)
        let presenter = AddPresenter()
        let interactor = AddInteractor()
        
        presenter.router = router
        presenter.view = viewController
        presenter.interactor = interactor
        
        viewController.output = presenter
        
        interactor.output = presenter
        
        return viewController
    }
    
}
