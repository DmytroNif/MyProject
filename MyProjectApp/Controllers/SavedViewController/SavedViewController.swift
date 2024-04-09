//
//  RightViewController.swift
//  MyProjectApp
//
//  Created by admin on 26/01/2024.
//

import UIKit
import RealmSwift
import ProgressHUD

class SavedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //    private var movies: [Movie] = []
    //    private var tvShow: [TVShow] = []
    private var dataArray: [SavedMoviesModel] = []
    
    var storage = StorageImpl()
    
    let mainView = SavedView()
    
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
        self.dataArray = []
        storage.fetchFavoriteMovies() { [weak self] movies in
            
            for i in movies {
                self?.dataArray.append(SavedMoviesModel(name: i.title ?? "No data", id: i.id ?? 0, type: .movie))
            }
            self?.mainView.tableView.reloadData()
        }
        
        storage.fetchFavoriteTVShow{ [weak self] tvShow in
            for i in tvShow {
                self?.dataArray.append(SavedMoviesModel(name: i.name ?? "No data", id: i.id ?? 0, type: .tv))
            }
            self?.mainView.tableView.reloadData()
        }
    }
    
    private func fetchFavoriteTV() {
        
    }
    
    
    //MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Повернення кількості рядків у таблиці
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Створення та налаштування рядка
        let cell = mainView.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        cell.textLabel?.text = dataArray[indexPath.row].name
        return cell
    }
    
    private func removeFromFavorites(indexPath: IndexPath) {
        if dataArray[indexPath.row].type == .movie {
            let movieId = dataArray[indexPath.row].id
            storage.delete(movieId: movieId ) { [weak self] result in
                switch result {
                case .success:
                    ProgressHUD.liveIcon(icon: .succeed)
                    self?.deleteMovie(indexPath: indexPath)
                case .failure:
                    ProgressHUD.liveIcon(icon: .failed)
                }
            }
        } else  {
            let tvShowId = dataArray[indexPath.row].id
            storage.deleteTV(tvShowId: tvShowId ) { [weak self] result in
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
        dataArray.remove(at: indexPath.row)
        
        mainView.tableView.beginUpdates()
        mainView.tableView.deleteRows(at: [indexPath], with: .fade)
        mainView.tableView.endUpdates()
    }
    
    private func deleteTVShow(indexPath: IndexPath) {
        dataArray.remove(at: indexPath.row)
        
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
        if dataArray[indexPath.row].type == .movie {
            let selectedMovie = dataArray[indexPath.row]
            let movieDetailsViewController = DetailsViewController()
            let movieID = selectedMovie.id
            
            NetworkManager().getDetails(id: movieID ) { result in
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
        } else {
            let selectedTV = dataArray[indexPath.row]
            let TVDetailsViewController = DetailsViewController()
            let tvID = selectedTV.id
            
            NetworkManager().getTVDetails(id: tvID ) { result in
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


struct SavedMoviesModel {
    var name: String
    var id: Int
    var type: CellType
    
    enum CellType {
        case tv
        case movie
    }
}
