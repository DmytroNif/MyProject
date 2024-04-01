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
    private var tvShow: [TVShow] = []
    
    var storage = StorageImpl()
    
    let mainView = RightView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "cell")
        registerCells()
        fetchFavoriteMovies()
        fetchFavoriteTV()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteMovies()
        fetchFavoriteTV()
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
    
    private func fetchFavoriteTV() {
        storage.fetchFavoriteTVShow{ [weak self] tvShow in
            self?.tvShow = tvShow
            self?.mainView.tableView.reloadData()
        }
    }

    
    //MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Повернення кількості рядків у таблиці
        return (movies.count + tvShow.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Створення та налаштування рядка
        let cell = mainView.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        if indexPath.row < movies.count { // Перевірка, чи індекс знаходиться у межах фільмів
                   cell.textLabel?.text = "\(movies[indexPath.row].title ?? "")"
               } else { // Якщо індекс виходить за межі фільмів, відображати телесеріали
                   cell.textLabel?.text = "\(tvShow[indexPath.row - movies.count].title ?? "")"
               }
               return cell
    }
    
    private func removeFromFavorites(indexPath: IndexPath) {
        if indexPath.row < movies.count {
                   let movieId = movies[indexPath.row].id
                   storage.delete(movieId: movieId ?? 0) { [weak self] result in
                       switch result {
                       case .success:
                           ProgressHUD.liveIcon(icon: .succeed)
                           self?.deleteMovie(indexPath: indexPath)
                       case .failure:
                           ProgressHUD.liveIcon(icon: .failed)
                       }
                   }
        } else  {
            let tvShowId = tvShow[indexPath.row - movies.count].id
            storage.deleteTV(tvShowId: tvShowId ?? 0) { [weak self] result in
                switch result {
                case .success:
                    ProgressHUD.liveIcon(icon: .succeed)
                    self?.deleteTVShow(indexPath: indexPath)
                case .failure:
                    ProgressHUD.liveIcon(icon: .failed)
                }
            }
        }
    }
    
    private func deleteMovie(indexPath: IndexPath) {
        movies.remove(at: indexPath.row)
        
        mainView.tableView.beginUpdates()
        mainView.tableView.deleteRows(at: [indexPath], with: .fade)
        mainView.tableView.endUpdates()
    }
    
    private func deleteTVShow(indexPath: IndexPath) {
        if indexPath.row < tvShow.count {
            tvShow.remove(at: indexPath.row)
            
            mainView.tableView.beginUpdates()
            mainView.tableView.deleteRows(at: [indexPath], with: .fade)
            mainView.tableView.endUpdates()
            
        }
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
//        
//        let selectedMovie = movies[indexPath.row]
//        let movieDetailsViewController = DetailsViewController()
//        movieDetailsViewController.movie = selectedMovie
//        let movieID = selectedMovie.id
//        
//        NetworkManager().getDetails(id: movieID ?? 0) { result in
//            // Обробити результат виклику API
//            switch result {
//            case .success(let movieDetails):
//                // У випадку успішного отримання даних відобразити їх у відповідному вигляді
//                movieDetailsViewController.mainView.setupUI(model: movieDetails)
//                
//                // Отримати доступ до навігаційного контролера та відкрити деталізований контролер
//                DispatchQueue.main.async {
//                    self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
//                }
//            case .failure(_):
//                // У разі невдалого запиту вивести повідомлення про помилку
//                print("Can't get data")
//            }
//        }
        if indexPath.row < movies.count {
                    let selectedMovie = movies[indexPath.row]
                    let movieDetailsViewController = DetailsViewController()
                    movieDetailsViewController.movie = selectedMovie
                    let movieID = selectedMovie.id
                    
                    NetworkManager().getDetails(id: movieID ?? 0) { result in
                        switch result {
                        case .success(let movieDetails):
                            movieDetailsViewController.mainView.setupUI(model: movieDetails)
                            movieDetailsViewController.type = .movie
                            DispatchQueue.main.async {
                                self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
                            }
                        case .failure(_):
                            print("Can't get data")
                        }
                    }
        } else if indexPath.row < tvShow.count {
                    let selectedTV = tvShow[indexPath.row]
                    let TVDetailsViewController = DetailsViewController()
                    TVDetailsViewController.tvShow = selectedTV
                    let tvID = selectedTV.id
                    
                    NetworkManager().getTVDetails(id: tvID ?? 0) { result in
                        switch result {
                        case .success(let tvDetails):
                            TVDetailsViewController.mainView.setupTVUI(model: tvDetails)
                            TVDetailsViewController.type = .tv
                            DispatchQueue.main.async {
                                self.navigationController?.pushViewController(TVDetailsViewController, animated: true)
                            }
                        case .failure(_):
                            print("Can't get data")
                        }
                    }
                }
    }
}

