//
//  SearchCell.swift
//  Movies
//
//  Created by Данік on 30/08/2023.
//

import Foundation
import UIKit
import SnapKit

class TrendingCell: UICollectionViewCell {
    static let identifier = "TrendingCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    let moviePoster = UIImageView().apply {
        $0.layer.cornerRadius = 15
        $0.image = UIImage(named: "welcomeScreenBackgroundImage")
    }
    
    let movieTitle = UILabel().apply {
        $0.text = "Amongus"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 14)
        $0.textColor = K.searchBlack
    }
    
    let movieDescription = UILabel().apply {
        $0.text = "Amongus sus Amongus sus, Amongus susAmongus sus Amongus sus Amongus sus Amongus susAmongus susAmongus sus"
        $0.numberOfLines = 3
        $0.font = UIFont(name: "OpenSans-Semibold", size: 14)
        $0.textColor = K.searchBlack
    }
    
//    func configure(withMovie movie: Movie) {
//        dateAndSourceLabel.text = dateAndSource
//        titleLabel.text = article.title
//        let placeholderImage = UIImage(named: "16and9")
//        imageView.kf.setImage(with: URL(string: article.pictureLink), placeholder: placeholderImage)
//        bookmarkButton.tintColor = article.isSaved ? .red : .white
//    }
    
    
    private func setupView() {
        self.backgroundColor = .clear
        addSubview(moviePoster)
        addSubview(movieTitle)
        addSubview(movieDescription)
        
        moviePoster.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width / 3)
        }
        
        movieTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(moviePoster.snp.right).offset(16)
        }
        
        movieDescription.snp.makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom).offset(4)
            make.left.equalTo(moviePoster.snp.right).offset(16)
            make.right.equalToSuperview()
        }
        
    }
}
