//
//  KnownForCell.swift
//  Movies
//
//  Created by Данік on 21/09/2023.
//

import Foundation
import MBCircularProgressBar
import SnapKit
import SDWebImage

class KnownForCell: UICollectionViewCell {
    
    static let identifier = "KnownForCell"
    
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
        $0.clipsToBounds = true // this needs to be true to see the rounded corners
        $0.contentMode = .scaleAspectFill
    }
    
    var titleLabel = UILabel().apply {
        $0.text = "Movie name"
        $0.numberOfLines = 2
        $0.font = UIFont(name: "OpenSans-Semibold", size: 14)
        $0.textColor = K.titleGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(withMovie movie: MovieOrTvInfo) {
        moviePoster.sd_setImage(with: URL(string: movie.posterUrl))
        titleLabel.text = movie.title
    }
    
    func setupView() {
        backgroundColor = .white
        addSubview(moviePoster)
        addSubview(titleLabel)
        
        moviePoster.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(moviePoster.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
            make.height.equalTo(18)
        }
    }
}
