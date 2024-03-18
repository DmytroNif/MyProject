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

class DetailsViewController: UIViewController {
    let mainView = DetailsView()
    private var movieList: [MovieList] = []
    var movieDetails: MovieDetails?
    var movie: Movie?
    var storage: Storage?
    weak var coordinator: MainCoordinator?
    
    var titleText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        mainView.saveButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        
        if let titleText {
            mainView.titleLabel.text = titleText
        }
        
//        mainView.setupUI(model: movieDetails)
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
   
    
    @objc
    func saveDetails() {
        print(movie?.title ?? "No data")
    }
    
    private func getMovie(indexPath: IndexPath) -> Movie {
            let movie = movieList[indexPath.section].previewMovies[indexPath.row]
            return movie
        }
    
    @objc
    func addToFavorites(indexPath: IndexPath) {
            let movie = getMovie(indexPath: indexPath)
            storage?.save(movie: movie) {
                ProgressHUD.liveIcon(icon: .added)
                print(movie.title )
            }
        }
}
