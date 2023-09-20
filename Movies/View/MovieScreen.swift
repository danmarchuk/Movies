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
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    // add a playButton
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
    
    let castController = CastHorizontalController()
    
    // if it is a TV show
    let currentSeasonLabel = UILabel().apply {
        $0.text = "Current Season"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 18)
        $0.textColor = K.movieScreenDarkBlueTextColor
    }
    
    let seeAllSeasonsLabel = UILabel().apply {
        $0.text = "See All"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 14)
        $0.textColor = K.seeAllColor
    }
    
    let currentSeasonImage = UIImageView().apply {
        $0.image = UIImage(named: "loki")
        $0.clipsToBounds = false
        $0.layer.cornerRadius = 5
    }
    
    let currentSeasonCountLabel = UILabel().apply {
        $0.text = "Season 1"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 14)
        $0.textColor = K.movieScreenDarkBlueTextColor
    }
    
    let yearAndEpisodesLabel = UILabel().apply {
        $0.text = "2021 | 6 Episodes"
        $0.font = UIFont(name: "OpenSans-Regular", size: 14)
        $0.textColor = K.movieScreenGray2
    }
    // end of "If it is a TV show"
    
    var grayDivider = UIView().apply{
        $0.frame = CGRect(x: 0, y: 0, width: 343, height: 1)
        $0.layer.backgroundColor = UIColor(red: 0.887, green: 0.887, blue: 0.887, alpha: 1).cgColor
    }
    
    let socialLabel = UILabel().apply {
        $0.text = "Social"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 18)
        $0.textColor = K.movieScreenDarkBlueTextColor
    }
    
    // custom segmented control
    
    let seeAllSocialLabel = UILabel().apply {
        $0.text = "See All"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 14)
        $0.textColor = K.seeAllColor
    }
    
    let socialDescriptionLabel = UILabel().apply {
        $0.text = "There are no discussions for Loki. Login to be first!"
        $0.font = UIFont(name: "OpenSans-Regular", size: 14)
        $0.textColor = .black
    }

    let mediaLabel = UILabel().apply {
        $0.text = "Media"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 18)
        $0.textColor = K.movieScreenDarkBlueTextColor
    }
    
    // custom segmented control
    
    // add a playButton
    let moviePoster2 = UIImageView().apply {
        $0.image = UIImage(named: "loki")
        $0.clipsToBounds = false
        $0.contentMode = .scaleAspectFill
    }
    
    var grayDivider2 = UIView().apply{
        $0.frame = CGRect(x: 0, y: 0, width: 343, height: 1)
        $0.layer.backgroundColor = UIColor(red: 0.887, green: 0.887, blue: 0.887, alpha: 1).cgColor
    }
    
    let recomendationsLabel = UILabel().apply {
        $0.text = "Recomendation"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 18)
        $0.textColor = K.movieScreenDarkBlueTextColor
    }
    
    let recomendationsController = InnerHorizontalViewController()
    
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
        
        // Setup constraints for scrollView
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        // Setup constraints for contentView
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(self)
            make.width.equalTo(self)
        }
        
        
        fitstStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
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
        
        seriesCastLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
        }
        
        seeAllActorsLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView.snp.bottom).offset(24)
            make.right.equalToSuperview().inset(15)
        }
        
        castController.view.snp.makeConstraints { make in
            make.top.equalTo(seriesCastLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 4.5)
        }
        
        currentSeasonLabel.snp.makeConstraints { make in
            make.top.equalTo(castController.view.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
        }
        
        seeAllSeasonsLabel.snp.makeConstraints { make in
            make.top.equalTo(castController.view.snp.bottom).offset(24)
            make.right.equalToSuperview().inset(15)
        }
        
        currentSeasonImage.snp.makeConstraints { make in
            make.top.equalTo(currentSeasonLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(48)
            make.width.equalTo(32)
        }

        currentSeasonCountLabel.snp.makeConstraints { make in
            make.top.equalTo(currentSeasonLabel.snp.bottom).offset(12)
            make.left.equalTo(currentSeasonImage.snp.right).offset(16)
        }

        yearAndEpisodesLabel.snp.makeConstraints { make in
            make.left.equalTo(currentSeasonImage.snp.right).offset(16)
            make.top.equalTo(currentSeasonCountLabel.snp.bottom).offset(2)
        }

        grayDivider.snp.makeConstraints { make in
            make.top.equalTo(currentSeasonImage.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }

        socialLabel.snp.makeConstraints { make in
            make.top.equalTo(grayDivider.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
        }

        seeAllSocialLabel.snp.makeConstraints { make in
            make.top.equalTo(grayDivider.snp.bottom).offset(24)
            make.right.equalToSuperview().inset(16)
        }
        
        socialDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(socialLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(18)
        }
        
        mediaLabel.snp.makeConstraints { make in
            make.top.equalTo(socialDescriptionLabel.snp.bottom).offset(49)
            make.left.equalToSuperview().offset(16)
        }
        
        moviePoster2.snp.makeConstraints { make in
            make.top.equalTo(mediaLabel.snp.bottom).offset(26)
            make.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        
        grayDivider2.snp.makeConstraints { make in
            make.top.equalTo(moviePoster2.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        recomendationsLabel.snp.makeConstraints { make in
            make.top.equalTo(grayDivider2.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
        }
        
        recomendationsController.view.snp.makeConstraints { make in
            make.top.equalTo(recomendationsLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
            make.height.equalTo(UIScreen.main.bounds.height / 3)
        }
        
        
    }
    
    func addSubviews() {
        // Add UIScrollView and ContentView
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Add other subviews to contentView instead of self
        contentView.addSubview(fitstStackView)
        contentView.addSubview(thirdStackView)
        contentView.addSubview(ageRestrictionLabel)
        contentView.addSubview(circularProgressBar)
        contentView.addSubview(percentageLabel)
        contentView.addSubview(movieLengthLabel)
        contentView.addSubview(moviePoster)
        contentView.addSubview(gernres.view)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(buttonsStackView)
        contentView.addSubview(seriesCastLabel)
        contentView.addSubview(seeAllActorsLabel)
        contentView.addSubview(castController.view)
        contentView.addSubview(currentSeasonLabel)
        contentView.addSubview(seeAllSeasonsLabel)
        contentView.addSubview(currentSeasonImage)
        contentView.addSubview(currentSeasonCountLabel)
        contentView.addSubview(yearAndEpisodesLabel)
        contentView.addSubview(grayDivider)
        contentView.addSubview(socialLabel)
        contentView.addSubview(seeAllSocialLabel)
        contentView.addSubview(socialDescriptionLabel)
        contentView.addSubview(mediaLabel)
        contentView.addSubview(moviePoster2)
        contentView.addSubview(grayDivider2)
        contentView.addSubview(recomendationsLabel)
        contentView.addSubview(recomendationsController.view)
    }
}
