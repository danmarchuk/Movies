//
//  ActingCell.swift
//  Movies
//
//  Created by Данік on 21/09/2023.
//

import Foundation
import SnapKit
import UIKit

class ActingCell: UICollectionViewCell {
    
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
        $0.image = UIImage(named: "loki")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
    }
    
    let transparenView = UIView().apply {
        $0.backgroundColor = .clear
    }
    
    let movieTitleLabel = UILabel().apply {
        $0.text = "Season 1"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 14)
        $0.textColor = K.movieScreenDarkBlueTextColor
    }
    
    // will be seen if this is a tv and will be hidden if this is a movie
    let numberOfEpisodesLabel = UILabel().apply {
        $0.text = " (6 eps)"
        $0.font = UIFont(name: "OpenSans-Regular", size: 14)
        $0.textColor = K.movieScreenDarkBlueTextColor
    }
    
    let releaseYearLabel = UILabel().apply {
        $0.text = " | 2021"
        $0.font = UIFont(name: "OpenSans-Regular", size: 14)
        $0.textColor = K.lightGrayColor
    }
    
    let asLabel = UILabel().apply {
        $0.text = "as "
        $0.font = UIFont(name: "OpenSans-Regular", size: 14)
        $0.textColor = K.veryLightGraycolor
    }
    
    let characterLabel = UILabel().apply {
        $0.text = "Detective Reese Rezek"
        $0.font = UIFont(name: "OpenSans-Regular", size: 14)
        $0.textColor = K.darkGrayColor
    }
    
    let transparenView2 = UIView().apply {
        $0.backgroundColor = .clear
    }
    
    
    func configure(withActingInfo info: ActingInfo) {
        moviePoster.sd_setImage(with: URL(string: info.posterUrl))
        movieTitleLabel.text = info.title
        
        if info.isMovie {
            numberOfEpisodesLabel.isHidden = true
        } else {
            if info.episodeCount <= 1 {
                // if the number of episodes is 1 then ep is shown
                numberOfEpisodesLabel.text = " (\(info.episodeCount) ep)"
            } else {
                // if the number of episodes is more than 1 then eps is shown
                numberOfEpisodesLabel.text = " (\(info.episodeCount) eps)"
            }
        }
        releaseYearLabel.text = " | \(info.releaseDate)"
        characterLabel.text = info.character
    }
    
    func setupView() {
        let stackView1 = UIStackView(arrangedSubviews: [movieTitleLabel, numberOfEpisodesLabel, releaseYearLabel])
        stackView1.axis = .horizontal
        stackView1.spacing = 0
        stackView1.alignment = .leading
        
        let stackView2 = UIStackView(arrangedSubviews: [asLabel, characterLabel, transparenView2])
        stackView2.axis = .horizontal
        stackView2.spacing = 0
        stackView2.distribution = .fill

        
        let verticalStackView = UIStackView(arrangedSubviews: [transparenView, stackView1, stackView2])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 2
        verticalStackView.distribution = .fillProportionally
        
        let mainHorizontalStackView = UIStackView(arrangedSubviews: [moviePoster, verticalStackView])
        mainHorizontalStackView.axis = .horizontal
        mainHorizontalStackView.spacing = 16
        
        mainHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainHorizontalStackView)
        
        moviePoster.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width / 9)
        }
        
        transparenView.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.height.equalTo(4)
        }
        
        mainHorizontalStackView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
    }
}
