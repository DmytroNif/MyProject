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

    //LeftView
    func start() {
        let storage: Storage = StorageImpl()
        let genersViewController = LeftViewController.instantiate()
        genersViewController.coordinator = self
        navigationController.pushViewController(genersViewController, animated: false)
    }
    
    func showDetails(id: Int) {
        let detailsViewController = DetailsViewController.instantiate()
        detailsViewController.coordinator = self
        navigationController.pushViewController(detailsViewController, animated: true)
    }
    
    //RightView
    func showMovieList(movieList: MovieList) {
        let movieListViewController = RightViewController.instantiate()
        movieListViewController.coordinator = self
        navigationController.pushViewController(movieListViewController, animated: true)
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
