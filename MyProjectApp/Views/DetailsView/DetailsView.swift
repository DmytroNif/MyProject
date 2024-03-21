//
//  DetailsView.swift
//  MyProjectApp
//
//  Created by admin on 07/02/2024.
//

import UIKit
import SnapKit
import YouTubeiOSPlayerHelper
import Lottie
import SDWebImage

class DetailsView: UIView {
    
    let containerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .white
        return obj
    }()
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let blureView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let obj = UIVisualEffectView(effect: blurEffect)
        return obj
    }()
    
    let youtubePlayer: YTPlayerView = {
        let obj = YTPlayerView()
        return obj
    }()
    
    let titleLabel: UILabel = {
        let obj = UILabel()
        return obj
    }()
    
    let dateLabel: UILabel = {
        let obj = UILabel()
        return obj
    }()
    
    let descriptionLabel: UILabel = {
        let obj = UILabel()
        obj.numberOfLines = 0
        obj.textAlignment = .center
        return obj
    }()
    
    let saveButton: UIButton = {
        let obj = UIButton()
        obj.setImage(UIImage(systemName: "bookmark"), for: .normal)
        obj.tintColor = .black
        return obj
    }()
    
    let animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "Animation - 1710925817311")
        animationView.loopMode = .playOnce
        animationView.contentMode = .scaleAspectFit
        animationView.isUserInteractionEnabled = false
        return animationView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        DetailsSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.addSubview(containerView)
        containerView.addSubview(backgroundImage)
        backgroundImage.addSubview(blureView)
        containerView.addSubview(youtubePlayer)
        containerView.addSubview(titleLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(saveButton)
        saveButton.addSubview(animationView)
    }
    
    func setupUI(model: MovieDetails) {
        titleLabel.text = model.title
        descriptionLabel.text = model.overview
        dateLabel.text = model.releaseDate
        
        backgroundImage.sd_setImage(with: model.imageURL)
        
        if let videoId = model.videos.movies.first?.key {
            youtubePlayer.load(withVideoId: videoId)
        } else {
            youtubePlayer.isHidden = true
        }
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        blureView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        youtubePlayer.snp.makeConstraints { make in
            make.height.equalTo(400)
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(youtubePlayer.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(50)
            make.centerY.equalToSuperview().offset(30)
        }
        
        animationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func DetailsSetup() {
        addSubviews()
        makeConstraints()
    }
}
