//
//  MovieScreenNode.swift
//  Movies
//
//  Created by Данік on 02/10/2023.
//

import Foundation

import AsyncDisplayKit

final class MovieScreenNode: ASDisplayNode {
    
    var buttons = ["My Lists", "Favorite", "Watchlist", "Rate"]
    // Constants for UI elements
    let titleLabel = ASTextNode()
    let yearLabel = ASTextNode()
    let ageRestrictionLabel = ASTextNode()
    let circularProgressBar = CircularProgressBarNode()
    let percentageLabel = ASTextNode()
    let moviePoster = ASNetworkImageNode()
//    let genres = GenreHorizontalControler()
    let descriptionLabel = ASTextNode()
    let buttonsStackView = ASDisplayNode()
    let seriesCastLabel = ASTextNode()
    let seeAllActorsLabel = ASTextNode()
//    let castController = CastHorizontalControllerNode()
    let currentSeasonLabel = ASTextNode()
    let seeAllSeasonsLabel = ASTextNode()
    let currentSeasonImage = ASImageNode()
    let currentSeasonCountLabel = ASTextNode()
    let yearAndEpisodesLabel = ASTextNode()
    let grayDivider = ASDisplayNode()
    let socialLabel = ASTextNode()
    let seeAllSocialButton = ASButtonNode()
    let socialDescriptionLabel = ASTextNode()
    let mediaLabel = ASTextNode()
//    let moviePoster2 =
    let grayDivider2 = ASDisplayNode()
    let recommendationsLabel = ASTextNode()
//    let recommendationsController = InnerHorizontalViewControllerNode()
    var myLitsButton = ASButtonNode()
    var favouriteButton = ASButtonNode()
    var watchlistButton = ASButtonNode()
    var rateButton = ASButtonNode()
    
    func configureButtons() {
        myLitsButton = createCustomButtonNode(withImage: UIImage(named: "rate") ?? UIImage(), withText: "My Lists")
        favouriteButton = createCustomButtonNode(withImage: UIImage(named: "rate") ?? UIImage(), withText: "Favourite")
        watchlistButton = createCustomButtonNode(withImage: UIImage(named: "rate") ?? UIImage(), withText: "Watchlist")
        rateButton = createCustomButtonNode(withImage: UIImage(named: "rate") ?? UIImage(), withText: "Rate")
    }
    
    func createCustomButtonNode(withImage image: UIImage, withText text: String) -> ASButtonNode {
        let buttonNode = ASButtonNode()
        
        // Set button properties
        buttonNode.backgroundColor = .clear
        buttonNode.cornerRadius = 5
        buttonNode.borderWidth = 1
        buttonNode.borderColor = K.movieScreenBorderColor

        // Create an image node
        let imageNode = ASImageNode()
        imageNode.image = image
        imageNode.contentMode = .scaleAspectFit

        // Create a text node for text
        let textNode = ASTextNode()
        textNode.attributedText = NSAttributedString(string: text, attributes: [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])

        // Create a vertical stack layout
        let stackLayout = ASStackLayoutSpec.vertical()
        stackLayout.alignItems = .center
        stackLayout.spacing = 8.0

        // Add image and text nodes to the stack layout
        stackLayout.children = [imageNode, textNode]

        // Set the stack layout as the button's content

        return buttonNode
    }

    override init() {
        super.init()
        configureButtons()
        automaticallyManagesSubnodes = true
        backgroundColor = .white
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        moviePoster.contentMode = .scaleAspectFill
        moviePoster.clipsToBounds = true
        
        
        // Configure mainStack
        let mainStack = ASStackLayoutSpec.vertical()
        mainStack.spacing = 16

        // Arrange titleLabel and yearLabel
        let titleYearSpec = ASStackLayoutSpec.horizontal()
        titleYearSpec.children = [titleLabel, yearLabel]
        titleYearSpec.spacing = 16

        // Arrange circularProgressBar and percentageLabel
        let progressSpec = ASStackLayoutSpec.horizontal()
        progressSpec.children = [circularProgressBar, percentageLabel]
        progressSpec.spacing = 16

        // Arrange ageRestrictionLabel and progressSpec
        let ageProgressSpec = ASStackLayoutSpec.horizontal()
        ageProgressSpec.children = [ageRestrictionLabel, progressSpec]
        ageProgressSpec.spacing = 16
        
        
        let desiredHeight = UIScreen.main.bounds.height * 0.25
        
        // Set the size of the moviePoster
        moviePoster.style.preferredSize = CGSize(width: constrainedSize.max.width, height: desiredHeight)
        
        
        //        let overlaySpec = ASOverlayLayoutSpec(child: fullWidthPosterSpec, overlay: moviePoster)
        
        // Add all the individual elements to the mainStack
        mainStack.children = [
            titleYearSpec,
            ageProgressSpec,
//            movieLengthLabel,
//            sizedPosterSpec,
//            genres.view,
            descriptionLabel,
            buttonsStackView,
            seriesCastLabel,
            seeAllActorsLabel,
//            castController.view,
            currentSeasonLabel,
            seeAllSeasonsLabel,
            currentSeasonImage,
            currentSeasonCountLabel,
            yearAndEpisodesLabel,
            grayDivider,
            socialLabel,
            seeAllSocialButton,
            socialDescriptionLabel,
            mediaLabel,
//            moviePoster2,
            grayDivider2,
//            recomendationsLabel,
//            recomendationsController.view
        ]
        
        // Now, let's stack the movie poster and main content vertically
            let fullStack = ASStackLayoutSpec.vertical()
            fullStack.children = [moviePoster, mainStack]


        // Apply an inset
        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 16), child: fullStack)

        return insetSpec
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
        circularProgressBar.updateValue(to: info.rating)

        // Configure percentage label
        percentageLabel.attributedText = NSAttributedString(string: "\(Int(info.rating))%", attributes: [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!,
            .foregroundColor: K.percentageGray
        ])

        // Configure movie poster image
        moviePoster.url = URL(string: info.posterUrl)

        // Configure genres controller (GenreHorizontalControlerNode)
//        genres.listOfGenres = info.genres

        // Configure description label
        descriptionLabel.attributedText = NSAttributedString(string: info.description, attributes: [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!,
            .foregroundColor: K.movieScreenGray2
        ])

        // Configure series cast label
        seriesCastLabel.attributedText = NSAttributedString(string: "Series Cast", attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 18)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])

        // Configure see all actors label
        seeAllActorsLabel.attributedText = NSAttributedString(string: "See All", attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.seeAllColor
        ])

        // Configure cast controller (CastHorizontalControllerNode)
//        castController.actors = info.actors

        // Configure current season elements (if it is a TV show)
        if !info.isMovie, let unwrappedCurrentSeasonDetails = info.currentSeasonDetails {
            currentSeasonCountLabel.attributedText = NSAttributedString(string: "Season \(unwrappedCurrentSeasonDetails.seasonNumber)", attributes: [
                .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
                .foregroundColor: K.movieScreenDarkBlueTextColor
            ])
            
            yearAndEpisodesLabel.attributedText = NSAttributedString(string: "\(unwrappedCurrentSeasonDetails.airYear) | \(unwrappedCurrentSeasonDetails.episodeNumber) Episodes", attributes: [
                .font: UIFont(name: "OpenSans-Regular", size: 14)!,
                .foregroundColor: K.movieScreenGray2
            ])
        }

        // Configure other elements as needed
        // ...
    }

}

