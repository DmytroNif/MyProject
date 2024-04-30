//
//  SearchViewController.swift
//  MyProjectApp
//
//  Created by admin on 23/03/2024.
//

//
//  DetailsViewController.swift
//  MyProjectApp
//
//  Created by admin on 07/02/2024.
//
import UIKit
import RealmSwift
import ProgressHUD
import YouTubeiOSPlayerHelper
import Lottie

class SearchViewController: UIViewController {
    let mainView = SearchView()
    var didSendEventClosure: ((SearchViewController.Event) -> Void)?
    
    private var networkService = NetworkManager()
    private let storageService = StorageImpl()
    private var searchTimer: Timer?
    private var searchText: String = ""
    private var searchResults: [Movie] = [] {
        didSet {
            mainView.searchTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        registerCells()
        mainView.searchTextField.delegate = self
        mainView.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    private func setupTable() {
        mainView.searchTableView.dataSource = self
        mainView.searchTableView.delegate = self
    }
    
    @objc private func performSearch() {
        networkService.searchMovies(query: searchText) { [weak self] result in
            switch result {
            case .success(let page):
                self?.searchResults = page.results
            case .failure(let error):
                print("Error searching movies: \(error)")
            }
        }
    }
    
    private func getMovie(indexPath: IndexPath) -> Movie? {
        let movie = searchResults[indexPath.row]
        return movie
    }
    
    private func showDetails(indexPath: IndexPath) {
        guard let movie = getMovie(indexPath: indexPath) else
        {
            return
        }
        didSendEventClosure?(.details(movie))
    }
    
    private func addToFavorites(indexPath: IndexPath) {
        guard let movie = getMovie(indexPath: indexPath) else { return }
        storageService.save(movie: movie) {
            ProgressHUD.liveIcon(icon: .added)
        }
    }
    
    private func registerCells() {
        mainView.searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(SearchTableViewCell.self, forIndexPath: indexPath)
        
        let movie = searchResults[indexPath.row]
        cell.setupCell(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showDetails(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addToFavorites = UIContextualAction(style: .normal, title: "") { [weak self] _, _, completionHandler in
            self?.addToFavorites(indexPath: indexPath)
            completionHandler(true)
        }
        addToFavorites.backgroundColor = .systemBlue
        addToFavorites.image = UIImage(systemName: "heart")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [addToFavorites])
        return swipeConfiguration
    }
}

extension SearchViewController: UITextFieldDelegate {
    @objc func textFieldDidChange() {
        searchTimer?.invalidate()
        searchText = mainView.searchTextField.text ?? ""
        
        guard !searchText.isEmpty else {
            searchResults = []
            return
        }
        
        self.searchText = mainView.searchTextField.text ?? ""
        searchTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(performSearch), userInfo: nil, repeats: false)
    }
}

extension SearchViewController {
    enum Event {
        case details(Movie)
        case detailsTV(TVShow)
    }
}
