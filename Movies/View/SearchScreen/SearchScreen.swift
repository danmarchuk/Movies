//
//  SearchScreen.swift
//  Movies
//
//  Created by Данік on 23/09/2023.
//

import Foundation
import SnapKit

@IBDesignable
final class SearchScreen: UIView {
    
    var collectionViewHeightConstraint: NSLayoutConstraint?
    
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
    
    var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search..."
        return searchBar
    }()
    
    let trendingLabel = UILabel().apply {
        $0.text = "Trending"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 18)
        $0.textColor = K.movieScreenDarkBlueTextColor
    }
    
    let verticalCollectionView = SearchVerticalTrendingControllerNode()
    
    
    func setupView() {
        backgroundColor = .white
        // Add scrollView to the main view
        addSubview(scrollView)

        // Set constraints for scrollView to be the size of the entire view
        scrollView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }

        // Add stackView to the scrollView
        scrollView.addSubview(stackView)

        // Set constraints for stackView inside the scrollView
        stackView.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.left.right.equalTo(self).inset(16)  // Add some padding on the sides
            make.centerX.equalTo(scrollView) // This ensures that the stackView doesn't expand beyond the scrollView's width, minus the side padding
            make.bottom.equalTo(scrollView) // This is important for the scrollView to know its content size
        }

        // The search bar and trending label will automatically get their intrinsic content sizes.
        // If you need any specific constraints for them, you can add them, but for now, I'm keeping it simple.
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(trendingLabel)
        stackView.addArrangedSubview(verticalCollectionView.view)
        


        // Inside setupView function:
        collectionViewHeightConstraint = verticalCollectionView.view.heightAnchor.constraint(equalToConstant: 250)
        collectionViewHeightConstraint?.isActive = true
        
//        verticalCollectionView.collectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)

        verticalCollectionView.view.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }

        searchBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        
        trendingLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
        }
    }
    
//    deinit {
//        verticalCollectionView.collectionView.removeObserver(self, forKeyPath: "contentSize")
//    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize", let newContentSize = change?[.newKey] as? CGSize {
            collectionViewHeightConstraint?.constant = newContentSize.height
        }
    }

}
