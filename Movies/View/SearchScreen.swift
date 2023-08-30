//
//  SearchScreen.swift
//  Movies
//
//  Created by Данік on 29/08/2023.
//

import Foundation
import MBCircularProgressBar
import SnapKit

@IBDesignable
class SearchScreen: UIView {
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // uiCollectionViewInnerCell
    let moviePoster = UIImageView().apply {
        $0.layer.cornerRadius = 15
        $0.image = UIImage(named: "welcomeScreenBackgroundImage")
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
    
    let titleLabel = UILabel().apply {
        $0.text = "Amongus sus"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 14)
        $0.textColor = K.titleGray
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
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(circularProgressBar.snp.bottom).offset(5)
        }

    }
}
