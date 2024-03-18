//
//  RightViewController.swift
//  MyProjectApp
//
//  Created by admin on 26/01/2024.
//

import UIKit
import RealmSwift
import ProgressHUD

class RightViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var movies: [Movie] = []
    
    var storage: Storage?
    
    let mainView = RightView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        registerCells()
        fetchFavoriteMovies()

    }
    
    override func loadView() {
        super.loadView()
        view = mainView
        
    }
    
    private func registerCells() {
        mainView.tableView.register(MovieTableViewCell.self)
    }
    
    private func fetchFavoriteMovies() {
        storage?.fetchFavoriteMovies() { [weak self] movies in
            self?.movies = movies
            self?.mainView.tableView.reloadData()
        }
    }
    
    //MARK: - UITableViewDataSource methods

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // Повернення кількості рядків у таблиці
            return movies.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // Створення та налаштування рядка
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "Row \(indexPath.row)"
            return cell
        }
    
    private func removeFromFavorites(indexPath: IndexPath) {
        let movieId = movies[indexPath.row].id
        storage?.delete(movieId: movieId) { [weak self] result in
//            switch result {
//            case .success:
//                ProgressHUD.liveIcon(icon: .succeed)
//              //  self?.deleteMovie(indexPath: indexPath)
//            case .failure:
//                ProgressHUD.liveIcon(icon: .failed)
//            }
        }
    }
    
//    private func deleteMovie(indexPath: IndexPath) {
//        movies.remove(at: indexPath.row)
//        
//        tableView.beginUpdates()
//        tableView.deleteRows(at: [indexPath], with: .fade)
//        tableView.endUpdates()
//    }
    
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let removeFromSavedAction = UIContextualAction(style: .normal, title: "", handler: { [weak self] (_, _, completionHandler) in
            self?.removeFromFavorites(indexPath: indexPath)
            completionHandler(true)
        })
         removeFromSavedAction.backgroundColor = .systemPink
         removeFromSavedAction.image = UIImage(systemName: "trash")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [removeFromSavedAction])
        return swipeConfiguration
    }


        //MARK: - UITableViewDelegate methods

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Обробка події вибору рядка
            
            let vc = DetailsViewController()
            vc.titleText = "Selected row \(indexPath.row)"
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
}
