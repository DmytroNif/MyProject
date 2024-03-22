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
    
    private var firstAnimationView: LottieAnimationView {
        return mainView.firstAnimationView
    }
    private var secondAnimationView: LottieAnimationView {
        return mainView.secondAnimationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.saveButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        
        
        if let titleText {
            mainView.titleLabel.text = titleText
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateSaveButtonState()
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    @objc
    func addToFavorites() {
        
        guard let movie = self.movie else { return }
        
        storage.fetchFavoriteMovies { [weak self] favoriteMovies in
            if let self = self {
                let isSaved = favoriteMovies.contains { $0.id == movie.id }
                if isSaved {
                    // Фільм вже збережений, видалимо його
                    self.storage.delete(movieId: movie.id) {_ in
                        ProgressHUD.liveIcon("Unsaved", icon: .failed)
                        self.playAnimation(animationType: .second)
                        print("\(movie.title) removed from favorites")
                        self.updateSaveButtonState()
                    }
                } else {
                    // Фільм не збережений, додамо його
                    self.storage.save(movie: movie) {
                        ProgressHUD.liveIcon("Saved", icon: .added)
                        self.playAnimation(animationType: .first)
                        print("\(movie.title) added to favorites")
                        self.updateSaveButtonState()
                    }
                }
            }
        }
      
    }
    func playAnimation(animationType: AnimationType) {
            switch animationType {
            case .first:
                // Відтворити першу анімацію
                self.mainView.firstAnimationView.isHidden = false
                self.mainView.firstAnimationView.play { _ in
                    self.mainView.firstAnimationView.isHidden = true
                }
            case .second:
                // Відтворити другу анімацію
                self.mainView.secondAnimationView.isHidden = false
                self.mainView.secondAnimationView.play { _ in
                    self.mainView.secondAnimationView.isHidden = true
                }
            }
        }
    enum AnimationType {
        case first, second
    }
    
    func updateSaveButtonState() {
        // Перевірте, чи фільм збережений
        if let movie = self.movie {
            storage.fetchFavoriteMovies { favoriteMovies in
                let isSaved = favoriteMovies.contains { $0.id == movie.id }
                DispatchQueue.main.async {
                    if isSaved {
                        self.mainView.saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                    } else {
                        self.mainView.saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
                    }
                }
            }
        }
        func saveButtonTapped() {
            
        }
    }
}
