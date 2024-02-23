//
//  MainCoordinator.swift
//  MyProjectApp
//
//  Created by admin on 22/02/2024.
//

//import UIKit
//
//class MainCoordinator: Coordinator {
//    var childCoordinators = [Coordinator]()
//    var navigationController: UINavigationController
//
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//
//    //LeftView
//    func start() {
//        let storage: Storage = StorageImpl()
//        let genersViewController = GenersViewController.instantiate()
//        genersViewController.coordinator = self
//        genersViewController.storage = storage
//        navigationController.pushViewController(genersViewController, animated: false)
//    }
//    
//    func showDetails(id: Int) {
//        let detailsViewController = DetailsViewController.instantiate()
//        detailsViewController.coordinator = self
//        detailsViewController.id = id
//        navigationController.pushViewController(detailsViewController, animated: true)
//    }
//    
//    //RightView
//    func showMovieList(movieList: MovieList) {
//        let movieListViewController = MovieListViewController.instantiate()
//        movieListViewController.coordinator = self
//        movieListViewController.movieList = movieList
//        navigationController.pushViewController(movieListViewController, animated: true)
//    }
//    
//    func showFavoriteList() {
//        let storage: Storage = StorageImpl()
//        let favoriteListViewController = FavoriteListViewController()
//        favoriteListViewController.coordinator = self
//        favoriteListViewController.storage = storage
//        navigationController.pushViewController(favoriteListViewController, animated: true)
//    }
//    
//    func showError(error: Error) {
//        let title = "Oops"
//        let message = error.localizedDescription
//        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        alertViewController.addAction(cancelAction)
//        navigationController.present(alertViewController, animated: true)
//    }
//}
