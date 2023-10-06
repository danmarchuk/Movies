//
//  MovieScreenNode.swift
//  Movies
//
//  Created by Данік on 02/10/2023.
//

import Foundation
import AsyncDisplayKit

final class MovieScreenNode: ASDisplayNode {
    
    let scrollNode = ASScrollNode()
    var buttons = ["My Lists", "Favorite", "Watchlist", "Rate"]
    // Constants for UI elements
    let titleLabel = ASTextNode()
    let yearLabel = ASTextNode()
    let ageRestrictionLabel = ASTextNode()
    let circularProgressBar = CircularProgressBarNode()
    let percentageLabel = ASTextNode()
    let length = ASTextNode()
    let moviePoster = ASNetworkImageNode()
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
    let moviePoster2 = ASNetworkImageNode()
    let grayDivider2 = ASDisplayNode()
    let recommendationsLabel = ASTextNode()
    let recommendationsController = InnerHorizontalCollectionNode()
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
        imageNode.style.preferredSize = CGSize(width: 20, height: 20)

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
        buttonNode.style.preferredSize = CGSize(width: 50, height: 50)
        // Set the stack layout as the button's content

        return buttonNode
    }

    override init() {
        super.init()
        configureButtons()
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
            movieOrSeriesCastLabel.attributedText = NSAttributedString(string: "Movie Cast", attributes: [
                .font: UIFont(name: "OpenSans-Semibold", size: 18)!,
                .foregroundColor: K.movieScreenDarkBlueTextColor
            ])
            currentSeasonCountLabel.isHidden = true
            yearAndEpisodesLabel.isHidden = true
            currentSeasonLabel.isHidden = true
            currentSeasonImage.isHidden = true
            seeAllSeasonsLabel.isHidden = true
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
            moviePosterSpec(constrainedSize),
            stackAfterThePosterSpec(constrainedSize),
            moviePoster2Spec(constrainedSize),
            stackAfterThePoster2Spec(constrainedSize)
        ]

        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: mainStack)
        
        scrollNode.layoutSpecBlock = { (_, _) -> ASLayoutSpec in
            return insetSpec
        }
        
        return ASWrapperLayoutSpec(layoutElement: scrollNode)
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

    private func moviePosterSpec(_ constrainedSize: ASSizeRange) -> ASNetworkImageNode {
        moviePoster.contentMode = .scaleAspectFill
        moviePoster.style.preferredSize = CGSize(width: constrainedSize.max.width, height: UIScreen.main.bounds.height * 0.25)
        return moviePoster
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

        buttonsStack.spacing = 8 // or your desired spacing
        buttonsStack.justifyContent = .spaceBetween // space them evenly
        
        buttonsStack.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 65)
        buttonsStack.style.flexGrow = 1.0
        
        genres.node.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 30)
        genres.node.style.flexGrow = 1.0
        
        castController.node.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 200)
        castController.node.style.flexGrow = 1.0
        
        stack.children = [
            genres.node,
            descriptionLabel,
            buttonsStack,
            seriesCastSpec(),
            castController.node,
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
        return horizontalSpec(leftNode: currentSeasonLabel, rightNode: seeAllSeasonsLabel)
    }

    private func seasonImageAndDetailsSpec() -> ASLayoutSpec {
        currentSeasonImage.style.preferredSize = CGSize(width: 32, height: 48)
        
        let detailsSpec = ASStackLayoutSpec.vertical()
        detailsSpec.children = [currentSeasonCountLabel, yearAndEpisodesLabel]
        detailsSpec.spacing = 2
        
        let spec = ASStackLayoutSpec.horizontal()
        spec.children = [currentSeasonImage, detailsSpec]
        spec.spacing = 16
        return spec
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

    private func moviePoster2Spec(_ constrainedSize: ASSizeRange) -> ASNetworkImageNode {
        moviePoster2.style.preferredSize = CGSize(width: constrainedSize.max.width, height: UIScreen.main.bounds.height * 0.25)
        return moviePoster2
    }
    
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

