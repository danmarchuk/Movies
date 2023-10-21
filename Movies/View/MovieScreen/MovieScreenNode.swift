//
//  MovieScreenNode.swift
//  Movies
//
//  Created by Данік on 02/10/2023.
//

import Foundation
import AsyncDisplayKit

final class MovieScreenNode: ASDisplayNode {
    
    var isMovie: Bool = false
    let scrollNode = ASScrollNode()
    var buttons = ["My Lists", "Favorite", "Watchlist", "Rate"]
    // Constants for UI elements
    let titleLabel = ASTextNode()
    let yearLabel = ASTextNode()
    let ageRestrictionLabel = ASTextNode()
    let circularProgressBar = CircularProgressBarNode()
    let percentageLabel = ASTextNode()
    let length = ASTextNode()
    let moviePoster = ASNetworkImageNode().apply {
        $0.placeholderColor = .lightGray
        $0.placeholderEnabled = true
        $0.defaultImage = UIImage(named: "placeholderMovie")
    }
    var playButton = ASButtonNode().apply {
        $0.setImage(UIImage(named: "playButtonImage"), for: .normal)
    }
    let moviePosterAndPlayButtonContainer = ASDisplayNode()
    let genres = GenresCollectionNodeController()
    let descriptionLabel = ASTextNode()
    let movieOrSeriesCastLabel = ASTextNode()
    let seeAllActorsLabel = ASTextNode()
    
    let castController = CastViewControllerNode()
    let currentSeasonLabel = ASTextNode()
    let seeAllSeasonsLabel = ASTextNode()
    let currentSeasonImage = ASNetworkImageNode().apply {
        $0.cornerRadius = 5
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.placeholderColor = .lightGray
        $0.placeholderEnabled = true
    }
    let currentSeasonCountLabel = ASTextNode()
    let yearAndEpisodesLabel = ASTextNode()
    let grayDivider = ASDisplayNode()
    
    let socialLabel = ASTextNode()
    let seeAllSocialLabel = ASTextNode()
    let socialDescriptionLabel = ASTextNode()
    let mediaLabel = ASTextNode()
    let moviePoster2 = ASNetworkImageNode().apply {
        $0.placeholderColor = .lightGray
        $0.placeholderEnabled = true
        $0.defaultImage = UIImage(named: "placeholderMovie")
    }
    var playButton2 = ASButtonNode().apply {
        $0.setImage(UIImage(named: "playButtonImage"), for: .normal)
    }
    let moviePosterAndPlayButtonContainer2 = ASDisplayNode()
    let grayDivider2 = ASDisplayNode()
    let recommendationsLabel = ASTextNode()
    let recommendationsController = InnerHorizontalCollectionNode()

    let myLitsButton = ASButtonNode().apply {
        $0.setTitle("My Lists", with: UIFont(name: "OpenSans-Regular", size: 14), with: K.searchBlack, for: .normal)
        $0.setImage(UIImage(named: "list"), for: .normal)
        $0.cornerRadius = 5
        $0.borderWidth = 1
        $0.laysOutHorizontally = false
        $0.borderColor = K.movieScreenBorderColor
    }
    var favouriteButton = ASButtonNode().apply {
        $0.setTitle("Favourite", with: UIFont(name: "OpenSans-Regular", size: 14), with: K.searchBlack, for: .normal)
        $0.setImage(UIImage(named: "fav"), for: .normal)
        $0.cornerRadius = 5
        $0.borderWidth = 1
        $0.laysOutHorizontally = false
        $0.borderColor = K.movieScreenBorderColor
    }
    var watchlistButton = ASButtonNode().apply {
        $0.setTitle("Watchlist", with: UIFont(name: "OpenSans-Regular", size: 14), with: K.searchBlack, for: .normal)
        $0.setImage(UIImage(named: "watch"), for: .normal)
        $0.cornerRadius = 5
        $0.borderWidth = 1
        $0.laysOutHorizontally = false
        $0.borderColor = K.movieScreenBorderColor
    }
    var rateButton = ASButtonNode().apply {
        $0.setTitle("Rate", with: UIFont(name: "OpenSans-Regular", size: 14), with: K.searchBlack, for: .normal)
        $0.setImage(UIImage(named: "rate"), for: .normal)
        $0.cornerRadius = 5
        $0.borderWidth = 1
        $0.laysOutHorizontally = false
        $0.borderColor = K.movieScreenBorderColor
    }
    

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        
        scrollNode.automaticallyManagesContentSize = true
        scrollNode.automaticallyManagesSubnodes = true
    }
    
    func configure(withMovieFullInfo info: MovieOrTVFullInfo) {
        // Configure title label
        titleLabel.attributedText = NSAttributedString(string: info.title, attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 18)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])

        // Configure year label
        yearLabel.attributedText = NSAttributedString(string: "(\(info.releaseYear))", attributes: [
            .font: UIFont(name: "OpenSans-Light", size: 14)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])

        // Configure age restriction label
        ageRestrictionLabel.attributedText = NSAttributedString(string: info.ageRestriction, attributes: [
            .font: UIFont(name: "OpenSans-Light", size: 14)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])

        // Configure circular progress bar (MBCircularProgressBarView)
        circularProgressBar.updateValue(to: info.rating * 10)

        let roundedPercentage = Int(ceil(info.rating * 10))
        // Configure percentage label
        percentageLabel.attributedText = NSAttributedString(string: "\(roundedPercentage)%", attributes: [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!,
            .foregroundColor: K.percentageGray
        ])
        
        length.attributedText = NSAttributedString(string: "\(info.length)m", attributes: [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!,
            .foregroundColor: K.percentageGray
        ])

        // Configure movie poster image
        moviePoster.url = URL(string: info.posterUrl)

        // Configure genres controller (GenreHorizontalControlerNode)
        genres.genres = info.genres

        // Configure description label
        descriptionLabel.attributedText = NSAttributedString(string: info.description, attributes: [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!,
            .foregroundColor: K.movieScreenGray2
        ])


        // Configure see all actors label
        seeAllActorsLabel.attributedText = NSAttributedString(string: "See All", attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.seeAllColor
        ])

        // Configure cast controller (CastHorizontalControllerNode)
        castController.actorShortInfo = info.actors
        
        // Configure series cast label
        currentSeasonLabel.attributedText = NSAttributedString(string: "Current Season", attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 18)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])

        // Configure see all actors label
        seeAllSeasonsLabel.attributedText = NSAttributedString(string: "See All", attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.seeAllColor
        ])
        
        // Configure current season elements (if it is a TV show)
        if !info.isMovie, let unwrappedCurrentSeasonDetails = info.currentSeasonDetails {
            isMovie = false
            currentSeasonCountLabel.attributedText = NSAttributedString(string: "Season \(unwrappedCurrentSeasonDetails.seasonNumber)", attributes: [
                .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
                .foregroundColor: K.movieScreenDarkBlueTextColor
            ])
            
            yearAndEpisodesLabel.attributedText = NSAttributedString(string: "\(unwrappedCurrentSeasonDetails.airYear) | \(unwrappedCurrentSeasonDetails.episodeNumber) Episodes", attributes: [
                .font: UIFont(name: "OpenSans-Regular", size: 14)!,
                .foregroundColor: K.movieScreenGray2
            ])
            
            movieOrSeriesCastLabel.attributedText = NSAttributedString(string: "Series Cast", attributes: [
                .font: UIFont(name: "OpenSans-Semibold", size: 18)!,
                .foregroundColor: K.movieScreenDarkBlueTextColor
            ])
            currentSeasonImage.url = URL(string: unwrappedCurrentSeasonDetails.posterUrl)
        } else {
            isMovie = true
            movieOrSeriesCastLabel.attributedText = NSAttributedString(string: "Movie Cast", attributes: [
                .font: UIFont(name: "OpenSans-Semibold", size: 18)!,
                .foregroundColor: K.movieScreenDarkBlueTextColor
            ])
        }
        
        socialLabel.attributedText = NSAttributedString(string: "Social", attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 18)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])
        
        seeAllSocialLabel.attributedText = NSAttributedString(string: "See All", attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.seeAllColor
        ])
        
        mediaLabel.attributedText = NSAttributedString(string: "Media", attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 18)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])
        
        moviePoster2.url = URL(string: info.posterUrl)
        
        recommendationsLabel.attributedText = NSAttributedString(string: "Recomendations", attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 18)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        let mainStack = ASStackLayoutSpec.vertical()
        mainStack.spacing = 16
        mainStack.children = [
            titleAndYearSpec(constrainedSize),
            ageAndProgressSpec(constrainedSize),
            createMoviePosterWithPlayButton(constrainedSize),
            stackAfterThePosterSpec(constrainedSize),
            createMoviePosterWithPlayButton2(constrainedSize),
            stackAfterThePoster2Spec(constrainedSize)
        ]

        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: mainStack)
        
        scrollNode.layoutSpecBlock = { (_, _) -> ASLayoutSpec in
            return insetSpec
        }
        
        return ASWrapperLayoutSpec(layoutElement: scrollNode)
    }
    
    func createMoviePosterWithPlayButton(_ constrainedSize: ASSizeRange) -> ASDisplayNode {
        moviePoster.contentMode = .scaleAspectFill
        moviePoster.style.preferredSize = CGSize(width: constrainedSize.max.width, height: UIScreen.main.bounds.height * 0.25)
        
        // Add the moviePoster and playButton as children to the container
        moviePosterAndPlayButtonContainer.automaticallyManagesSubnodes = true
        moviePosterAndPlayButtonContainer.layoutSpecBlock = { _, _ in
            let centeringStack = ASStackLayoutSpec.vertical()
            centeringStack.justifyContent = .center
            centeringStack.alignItems = .center
            centeringStack.children = [self.playButton]

            return ASOverlayLayoutSpec(child: self.moviePoster, overlay: centeringStack)
        }

        return moviePosterAndPlayButtonContainer
    }
    
    func createMoviePosterWithPlayButton2(_ constrainedSize: ASSizeRange) -> ASDisplayNode {
        moviePoster2.contentMode = .scaleAspectFill
        moviePoster2.style.preferredSize = CGSize(width: constrainedSize.max.width, height: UIScreen.main.bounds.height * 0.25)
        
        // Add the moviePoster and playButton as children to the container
        moviePosterAndPlayButtonContainer2.automaticallyManagesSubnodes = true
        moviePosterAndPlayButtonContainer2.layoutSpecBlock = { _, _ in
            let centeringStack = ASStackLayoutSpec.vertical()
            centeringStack.justifyContent = .center
            centeringStack.alignItems = .center
            centeringStack.children = [self.playButton2]

            return ASOverlayLayoutSpec(child: self.moviePoster2, overlay: centeringStack)
        }

        return moviePosterAndPlayButtonContainer2
    }
    


    private func titleAndYearSpec(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let spec = ASStackLayoutSpec.horizontal()
        spec.children = [titleLabel, yearLabel]
        spec.spacing = 4
        spec.alignItems = .center
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: spec)
    }

    private func ageAndProgressSpec(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        circularProgressBar.style.preferredSize = CGSize(width: 15, height: 15)
        let progressSpec = ASStackLayoutSpec.horizontal()
        progressSpec.children = [circularProgressBar, percentageLabel]
        progressSpec.spacing = 4
        progressSpec.alignItems = .center
        
        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
        
        let spec = ASStackLayoutSpec.horizontal()
        spec.children = [ageRestrictionLabel, progressSpec, spacer, length]
        spec.spacing = 27
        spec.alignItems = .center
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: spec)
    }


    private func stackAfterThePosterSpec(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec.vertical()
        stack.spacing = 16
        
        let buttonsStack = ASStackLayoutSpec.horizontal()
        buttonsStack.children = [
            myLitsButton,
            favouriteButton,
            watchlistButton,
            rateButton
        ]

        myLitsButton.style.preferredSize = CGSize(width: constrainedSize.max.width / 5, height: constrainedSize.max.width / 5 - 10)
        favouriteButton.style.preferredSize = CGSize(width: constrainedSize.max.width / 5, height: constrainedSize.max.width / 5 - 10)
        watchlistButton.style.preferredSize = CGSize(width: constrainedSize.max.width / 5, height: constrainedSize.max.width / 5 - 10)
        rateButton.style.preferredSize = CGSize(width: constrainedSize.max.width / 5, height: constrainedSize.max.width / 5 - 10)
        
        buttonsStack.justifyContent = .spaceBetween // space them evenly
        buttonsStack.style.flexGrow = 1.0
        
        let buttonStackSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: buttonsStack)
        
        genres.node.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 30)
        genres.node.style.flexGrow = 1.0
        
        castController.node.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 200)
        castController.node.style.flexGrow = 1.0
        let castControllerSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: -16, bottom: 0, right: -16), child: castController.node)
        
        stack.children = [
            genres.node,
            descriptionLabel,
            buttonStackSpec,
            seriesCastSpec(),
            castControllerSpec,
            currentSeasonSpec(),
            seasonImageAndDetailsSpec(),
            dividerSpec(constrainedSize, grayDivider),
            socialSpec(),
            socialDescriptionLabel,
            mediaLabel]
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: stack)
    }
    
    private func seriesCastSpec() -> ASLayoutSpec {
        return horizontalSpec(leftNode: movieOrSeriesCastLabel, rightNode: seeAllActorsLabel)
    }
    
    private func currentSeasonSpec() -> ASLayoutSpec {
        if !isMovie {
            return horizontalSpec(leftNode: currentSeasonLabel, rightNode: seeAllSeasonsLabel)
        } else {
            let emptySpec = ASStackLayoutSpec.horizontal()
            emptySpec.style.preferredSize = CGSize(width: 0, height: 0)
            return emptySpec
        }
    }

    private func seasonImageAndDetailsSpec() -> ASLayoutSpec {
        if !isMovie {
            currentSeasonImage.style.preferredSize = CGSize(width: 32, height: 48)
            
            let detailsSpec = ASStackLayoutSpec.vertical()
            detailsSpec.children = [currentSeasonCountLabel, yearAndEpisodesLabel]
            detailsSpec.spacing = 2
            
            let spec = ASStackLayoutSpec.horizontal()
            spec.children = [currentSeasonImage, detailsSpec]
            spec.spacing = 16
            return spec
        } else {
            let emptySpec = ASStackLayoutSpec.horizontal()
            emptySpec.style.preferredSize = CGSize(width: 0, height: 0)
            return emptySpec
        }
    }

    private func dividerSpec(_ constrainedSize: ASSizeRange, _ divider: ASDisplayNode) -> ASLayoutSpec {
        divider.backgroundColor = UIColor(cgColor: K.movieScreenBorderColor)
        divider.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 1)
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: divider)
    }

    private func socialSpec() -> ASLayoutSpec {
        return horizontalSpec(leftNode: socialLabel, rightNode: seeAllSocialLabel)
    }

    private func horizontalSpec(leftNode: ASDisplayNode, rightNode: ASDisplayNode) -> ASLayoutSpec {
        let spec = ASStackLayoutSpec.horizontal()
        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
        spec.children = [leftNode, spacer, rightNode]
        return spec
    }

//    private func moviePoster2Spec(_ constrainedSize: ASSizeRange) -> ASNetworkImageNode {
//        moviePoster2.style.preferredSize = CGSize(width: constrainedSize.max.width, height: UIScreen.main.bounds.height * 0.25)
//        return moviePoster2
//    }
    
    private func stackAfterThePoster2Spec(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec.vertical()
        stack.spacing = 16
        
        recommendationsController.node.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 200)
        recommendationsController.node.style.flexGrow = 1.0
        
        stack.children = [
            dividerSpec(constrainedSize, grayDivider2),
            recommendationsLabel,
            recommendationsController.node
        ]
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: stack)
    }
}

