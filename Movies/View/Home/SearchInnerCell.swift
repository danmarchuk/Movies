//
//  SearchScreen.swift
//  Movies
//
//  Created by Данік on 29/08/2023.
//

import Foundation
import MBCircularProgressBar
import SnapKit
import SDWebImage

class SearchInnerCell: UICollectionViewCell {
    
    static let identifier = "SearchInnerCell"
    
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
    }
    
    let circularProgressBar = MBCircularProgressBarView().apply {
        $0.value = 50
        $0.maxValue = 100
        $0.showValueString = false
        $0.progressColor = .green
        $0.progressStrokeColor = .green
        $0.progressCapType = 1
        $0.progressAngle = 100
        $0.progressLineWidth = 1
        $0.emptyLineColor = K.lightGreenProgresColor
        $0.emptyLineStrokeColor = K.lightGreenProgresColor
        $0.emptyLineWidth = 1
        $0.progressRotationAngle = 50
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
    }
    
    let percentageLabel = UILabel().apply {
        $0.text = "66%"
        $0.font = UIFont(name: "OpenSans-Regular", size: 14)
        $0.textColor = K.percentageGray
    }
    
    var titleLabel = UILabel().apply {
        $0.text = "Movie name"
        $0.numberOfLines = 2
        $0.font = UIFont(name: "OpenSans-Semibold", size: 14)
        $0.textColor = K.titleGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(withMovie movie: Content) {
        moviePoster.sd_setImage(with: URL(string: movie.posterUrl))
        titleLabel.text = movie.title
        circularProgressBar.value = CGFloat(movie.rating)
        percentageLabel.text = "\(movie.rating * 10)%"
        configureTheCircularProgressBar(withRating: Double(movie.rating))
    }
    
    func setupView() {
        backgroundColor = .white
        addSubview(moviePoster)
        addSubview(circularProgressBar)
        addSubview(percentageLabel)
        addSubview(titleLabel)
        
        moviePoster.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        circularProgressBar.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(moviePoster.snp.bottom).offset(10)
            make.height.width.equalTo(15)
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.left.equalTo(circularProgressBar.snp.right).offset(4)
            make.top.equalTo(moviePoster.snp.bottom).offset(10)
            make.height.equalTo(18)
            //            make.width.equalTo(27)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(percentageLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview()
            make.height.equalTo(18)
        }
    }
    
    func configureTheCircularProgressBar(withRating rating: Double) {
        // Set the circular progress bar color based on the rating
        if rating >= 7.0 {
            // Green for high-rated movies
            circularProgressBar.progressColor = .green
            circularProgressBar.progressStrokeColor = .green
            circularProgressBar.emptyLineColor = K.lightGreenProgresColor
            circularProgressBar.emptyLineStrokeColor = K.lightGreenProgresColor
        } else if rating >= 5.0 {
            // Orange for moderately rated movies
            circularProgressBar.progressColor = .orange
            circularProgressBar.progressStrokeColor = .orange
            circularProgressBar.emptyLineColor = K.lightOrangeProgressColor
            circularProgressBar.emptyLineStrokeColor = K.lightOrangeProgressColor
        } else {
            // Red for low-rated movies
            circularProgressBar.progressColor = .red
            circularProgressBar.progressStrokeColor = .red
            circularProgressBar.emptyLineColor = K.lightRedProgressColor
            circularProgressBar.emptyLineStrokeColor = K.lightRedProgressColor
        }
        
        // Update the progress value and percentage label
        circularProgressBar.value = CGFloat(rating * 10)
    }
}
