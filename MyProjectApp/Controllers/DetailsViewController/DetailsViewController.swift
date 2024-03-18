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

    @objc
    func addToFavorites() {
        if let movie = self.movie {
            storage?.save(movie: movie) {
                ProgressHUD.liveIcon(icon: .added)
                print(movie.title )
            }
        }
        }
}
