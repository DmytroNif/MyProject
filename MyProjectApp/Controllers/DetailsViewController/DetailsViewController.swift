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

class DetailsViewController: UIViewController {
    let mainView = DetailsView()
    var movieDetails: MovieDetails?
    var movie: Movie?
    var storage = StorageImpl()
    weak var coordinator: MainCoordinator?
    
    var titleText: String?
    
    private var animationView: LottieAnimationView {
            return mainView.animationView
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.saveButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
       // mainView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        if let titleText {
            mainView.titleLabel.text = titleText
        }
//        mainView.seztupBackgroundImage(model: movie!)
//        mainView.setupUI(model: movieDetails)
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
  
    @objc
    func addToFavorites() {
        if let movie = self.movie {
            storage.save(movie: movie) {
                ProgressHUD.liveIcon(icon: .added)
                self.mainView.animationView.play()
                print(movie.title )
            }
        }
        }
    @objc func saveButtonTapped() {
            // Запускаємо анімацію при натисканні на кнопку
            animationView.play()
        }
}
