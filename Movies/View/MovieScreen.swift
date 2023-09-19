//
//  MovieScreen.swift
//  Movies
//
//  Created by Данік on 18/09/2023.
//

import Foundation
import MBCircularProgressBar
import SnapKit

@IBDesignable
final class MovieScreen: UIView {
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var buttons = ["My Lists", "Favorite", "Watchlist", "Rate"]
    
    var titleLabel = UILabel().apply {
        $0.text = "Loki"
        $0.numberOfLines = 1
        $0.font = UIFont(name: "OpenSans-Semibold", size: 18)
        $0.textColor = K.movieScreenDarkBlueTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var yearLabel = UILabel().apply {
        $0.text = "(2021)"
        $0.numberOfLines = 1
        $0.font = UIFont(name: "OpenSans-Light", size: 14)
        $0.textColor = K.movieScreenDarkBlueTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let fitstStackView = UIStackView().apply{
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 4
    }
    
    var ageRestrictionLabel = UILabel().apply {
        $0.text = "TV-14"
        $0.numberOfLines = 1
        $0.font = UIFont(name: "OpenSans-Light", size: 14)
        $0.textColor = K.movieScreenDarkBlueTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
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
    
    let secondStackView = UIStackView().apply{
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 4
    }
    
    let thirdStackView = UIStackView().apply{
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 27
    }
    
    let movieLengthLabel = UILabel().apply {
        $0.text = "52m"
        $0.font = UIFont(name: "OpenSans-Regular", size: 14)
        $0.textColor = K.percentageGray
    }
    
    let moviePoster = UIImageView().apply {
        $0.image = UIImage(named: "loki")
        $0.clipsToBounds = false
    }
    
    let gernres = GenreHorizontalControler()
    
    let descriptionLabel = UILabel().apply {
        $0.text = "After stealing the Tesseract during the events of “Avengers: Endgame,” an alternate version of Loki is brought to the mysterious Time Variance Authority."
        $0.font = UIFont(name: "OpenSans-Regular", size: 14)
        $0.numberOfLines = 3
        $0.textColor = K.movieScreenGray2
    }
    
    let buttonsStackView = UIStackView().apply{
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    let seriesCastLabel = UILabel().apply {
        $0.text = "Series Cast"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 18)
        $0.textColor = K.movieScreenDarkBlueTextColor
    }
    
    let seeAllActorsLabel = UILabel().apply {
        $0.text = "See All"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 14)
        $0.textColor = K.seeAllColor
    }
    
    
    
    
    
    func createButtons() {
        for button in buttons {
            let button = FuncManager.createCustomButton(withImage: UIImage(named: "rate") ?? UIImage(), withText: button)
            buttonsStackView.addArrangedSubview(button)
        }
    }
    
    func setupView() {
        backgroundColor = .white
        addSubviews()
        createButtons()
        setupConstraints()
    }
    
    func setupConstraints() {
        fitstStackView.addArrangedSubview(titleLabel)
        fitstStackView.addArrangedSubview(yearLabel)
        
        secondStackView.addArrangedSubview(circularProgressBar)
        secondStackView.addArrangedSubview(percentageLabel)
        
        thirdStackView.addArrangedSubview(ageRestrictionLabel)
        thirdStackView.addArrangedSubview(secondStackView)
        
        
        fitstStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(104)
        }
        
        thirdStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(15)
            make.top.equalTo(fitstStackView.snp.bottom).offset(4)
        }
        
        movieLengthLabel.snp.makeConstraints { make in
            make.top.equalTo(thirdStackView.snp.top)
            make.right.equalToSuperview().inset(16)
        }
        
        moviePoster.snp.makeConstraints { make in
            make.top.equalTo(movieLengthLabel.snp.bottom).offset(11)
            make.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        
        gernres.view.snp.makeConstraints { make in
            make.top.equalTo(moviePoster.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(gernres.view.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(65)
        }
    }
    
    func addSubviews() {
        addSubview(fitstStackView)
        addSubview(thirdStackView)
        addSubview(ageRestrictionLabel)
        addSubview(circularProgressBar)
        addSubview(percentageLabel)
        addSubview(movieLengthLabel)
        addSubview(moviePoster)
        addSubview(gernres.view)
        addSubview(descriptionLabel)
        addSubview(buttonsStackView)
    }
}
