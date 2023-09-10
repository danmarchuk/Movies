//
//  SearchScreen.swift
//  Movies
//
//  Created by Данік on 29/08/2023.
//

import Foundation
import MBCircularProgressBar
import SnapKit

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
    
    // uiCollectionViewInnerCell
    let moviePoster = UIImageView().apply {
        $0.layer.cornerRadius = 15
        $0.image = UIImage(named: "welcomeScreenBackgroundImage")
        $0.layer.cornerRadius = 15
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
        $0.text = "66%"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 14)
        $0.textColor = K.titleGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(withImage image: UIImage, withTitle title: String, withRating rating: Int ) {
        moviePoster.image = image
        titleLabel.text = title
        circularProgressBar.value = CGFloat(rating)
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
            make.left.equalToSuperview()
            make.top.equalTo(percentageLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview()
            make.height.equalTo(18)
        }

    }
}
