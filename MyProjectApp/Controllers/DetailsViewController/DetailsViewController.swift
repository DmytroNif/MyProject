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
    var movie: Movie?
    var tvShow: TVShow?
    var storage = StorageImpl()
    weak var coordinator: MainCoordinator?
    var titleText: String?
    var type: TypeCell?
    
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
//        switch type {
//        case .tv:
//            guard let tvShow = self.tvShow else { return }
//            
//            storage.fetchFavoriteTVShow { [weak self] favoriteTV in
//                if let self = self {
//                    let isSaved = favoriteTV.contains { $0.id == tvShow.id }
//                    if isSaved {
//                        // Фільм вже збережений, видалимо його
//                        self.storage.deleteTV(tvShowId: tvShow.id ?? 0) {_ in
//                            ProgressHUD.liveIcon("Unsaved", icon: .failed)
//                            self.playAnimation(animationType: .second)
//                            print("\(tvShow.title ?? "") removed from favorites")
//                            self.updateSaveButtonState()
//                        }
//                    } else {
//                        // Фільм не збережений, додамо його
//                        self.storage.saveTV(tvShow: tvShow) {
//                            ProgressHUD.liveIcon("Saved", icon: .added)
//                            self.playAnimation(animationType: .first)
//                            print("\(tvShow.title ?? "") added to favorites")
//                            self.updateSaveButtonState()
//                        }
//                    }
//                }
//            }
//        case .movie :
//            guard let movie = self.movie else { return }
//            
//            storage.fetchFavoriteMovies { [weak self] favoriteMovies in
//                if let self = self {
//                    let isSaved = favoriteMovies.contains { $0.id == movie.id }
//                    if isSaved {
//                        // Фільм вже збережений, видалимо його
//                        self.storage.delete(movieId: movie.id ?? 0) {_ in
//                            ProgressHUD.liveIcon("Unsaved", icon: .failed)
//                            self.playAnimation(animationType: .second)
//                            print("\(movie.title ?? "") removed from favorites")
//                            self.updateSaveButtonState()
//                        }
//                    } else {
//                        // Фільм не збережений, додамо його
//                        self.storage.save(movie: movie) {
//                            ProgressHUD.liveIcon("Saved", icon: .added)
//                            self.playAnimation(animationType: .first)
//                            print("\(movie.title ?? "") added to favorites")
//                            self.updateSaveButtonState()
//                        }
//                    }
//                }
//            }
//        case .none:
//            print("")
//        }

        guard let movie = self.movie else { return }
        
        storage.fetchFavoriteMovies { [weak self] favoriteMovies in
            if let self = self {
                let isSaved = favoriteMovies.contains { $0.id == movie.id }
                if isSaved {
                    // Фільм вже збережений, видалимо його
                    self.storage.delete(movieId: movie.id ?? 0) {_ in
                        ProgressHUD.liveIcon("Unsaved", icon: .failed)
                        self.playAnimation(animationType: .second)
                        print("\(movie.title ?? "") removed from favorites")
                        self.updateSaveButtonState()
                    }
                } else {
                    // Фільм не збережений, додамо його
                    self.storage.save(movie: movie) {
                        ProgressHUD.liveIcon("Saved", icon: .added)
                        self.playAnimation(animationType: .first)
                        print("\(movie.title ?? "") added to favorites")
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
        switch type {
        case .tv:
            if let tvShow = self.tvShow {
                storage.fetchFavoriteTVShow { favoriteTVShow in
                    let isSaved = favoriteTVShow.contains { $0.id == tvShow.id }
                    DispatchQueue.main.async {
                        if isSaved {
                            self.mainView.saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                        } else {
                            self.mainView.saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
                        }
                    }
                }
            }
        case .movie:
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
        case nil:
            print("")
        }
//        if let movie = self.movie {
//            storage.fetchFavoriteMovies { favoriteMovies in
//                let isSaved = favoriteMovies.contains { $0.id == movie.id }
//                DispatchQueue.main.async {
//                    if isSaved {
//                        self.mainView.saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
//                    } else {
//                        self.mainView.saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
//                    }
//                }
//            }
//        }
    }
}
