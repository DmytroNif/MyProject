//
//  MainCoordinator.swift
//  MyProjectApp
//
//  Created by admin on 22/02/2024.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let storage: Storage = StorageImpl()
        let leftViewController = LeftViewController.instantiate()
        leftViewController.coordinator = self
        navigationController.pushViewController(leftViewController, animated: false)
    }
    
    func showDetails(id: Int) {
        let detailsViewController = DetailsViewController.instantiate()
        detailsViewController.coordinator = self
        navigationController.pushViewController(detailsViewController, animated: true)
    }
    
    func showRightViewController(movieList: MovieList) {
        let rightViewController = RightViewController.instantiate()
       // rightViewController.coordinator = self
        navigationController.pushViewController(rightViewController, animated: true)
    }
    
    func showError(error: Error) {
        let title = "Oops"
        let message = error.localizedDescription
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertViewController.addAction(cancelAction)
        navigationController.present(alertViewController, animated: true)
    }
}
