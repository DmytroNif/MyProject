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
    
    var storage = StorageImpl()
    
    let mainView = RightView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "cell")
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
        storage.fetchFavoriteMovies() { [weak self] movies in
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
        let cell = mainView.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        cell.textLabel?.text = "\(movies[indexPath.row].title)"
        return cell
    }
    
    private func removeFromFavorites(indexPath: IndexPath) {
        let movieId = movies[indexPath.row].id
        storage.delete(movieId: movieId) { [weak self] result in
            switch result {
            case .success:
                ProgressHUD.liveIcon(icon: .succeed)
                self?.deleteMovie(indexPath: indexPath)
            case .failure:
                ProgressHUD.liveIcon(icon: .failed)
            }
        }
    }
    
    private func deleteMovie(indexPath: IndexPath) {
        movies.remove(at: indexPath.row)
        
        mainView.tableView.beginUpdates()
        mainView.tableView.deleteRows(at: [indexPath], with: .fade)
        mainView.tableView.endUpdates()
    }
    
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
        
        let selectedMovie = movies[indexPath.row]
        let movieDetailsViewController = DetailsViewController()
        movieDetailsViewController.movie = selectedMovie
        let movieID = selectedMovie.id
        
        NetworkManager().getDetails(id: movieID) { result in
            // Обробити результат виклику API
            switch result {
            case .success(let movieDetails):
                // У випадку успішного отримання даних відобразити їх у відповідному вигляді
                movieDetailsViewController.mainView.setupUI(model: movieDetails)
                
                // Отримати доступ до навігаційного контролера та відкрити деталізований контролер
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
                }
            case .failure(_):
                // У разі невдалого запиту вивести повідомлення про помилку
                print("Can't get data")
            }
        }
    }
}

