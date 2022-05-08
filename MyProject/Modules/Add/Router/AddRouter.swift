//
//  AddRouter.swift
//  MyProject
//
//  Created by Anastasiia Chechina on 05.05.2022.
//

import UIKit

final class AddRouter {

    var viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

}

extension AddRouter: AddRouterInput {

    func showError(with text: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: text,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }

    func showDone(with text: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: "Выполнено",
            message: text,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            completion?()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
}
