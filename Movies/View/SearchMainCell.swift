//
//  SearchCell.swift
//  Movies
//
//  Created by Данік on 05/09/2023.
//

import Foundation
import UIKit
import SnapKit
import LUNSegmentedControl

@IBDesignable
class SearchMainCell: UICollectionViewCell {
    
    static let identifier = "SearchMainCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    let mainLabel = UILabel().apply {
        $0.text = "What's Popular"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 18)
        $0.textColor = K.searchBlack
    }
    
    let seeAllLabel = UILabel().apply {
        $0.text = "See All"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 14)
        $0.textColor = K.seeAllColor
    }
    
    let segmentedControll = LUNSegmentedControl()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    func configure(withTitle title: String, withSegmentedControl: [String], withMovies movies: [Movie]) {
        
    }
    
    
    func setupView() {
        segmentedControll.delegate = self
        segmentedControll.dataSource = self
        segmentedControll.cornerRadius = 25
        segmentedControll.shapeStyle = .roundedRect
        segmentedControll.selectorViewColor = .clear
        segmentedControll.textColor = .black
        segmentedControll.layer.borderWidth = 1
        segmentedControll.layer.borderColor = K.gradientColorTwo.cgColor
        segmentedControll.textFont = UIFont(name: "OpenSans-Regular", size: 14)
//        segmentedControll.applyCornerRadiusToSelectorView = true
        segmentedControll.selectedStateTextColor = .black
        segmentedControll.reloadData()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchInnerCell.self, forCellWithReuseIdentifier: SearchInnerCell.identifier)
        
        backgroundColor = .white
        addSubview(collectionView)
        addSubview(mainLabel)
        addSubview(seeAllLabel)
        addSubview(segmentedControll)
        
        mainLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        seeAllLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
        }
        
        segmentedControll.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControll.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
}

extension SearchMainCell: LUNSegmentedControlDelegate, LUNSegmentedControlDataSource {
    func numberOfStates(in segmentedControl: LUNSegmentedControl!) -> Int {
        2
    }

    func segmentedControl(_ segmentedControl: LUNSegmentedControl!, titleForStateAt index: Int) -> String! {
        return "HEY"
    }


    func segmentedControl(_ segmentedControl: LUNSegmentedControl!, gradientColorsForStateAt index: Int) -> [UIColor]! {
        return [K.gradientColorOne, K.gradientColorTwo]
    }

    func segmentedControl(_ segmentedControl: LUNSegmentedControl!, didChangeStateFromStateAt fromIndex: Int, toStateAt toIndex: Int) {
        segmentedControl.textFont = UIFont(name: "OpenSans-Bold", size: 14)
//        segmentedControl.reloadData()
        
    }
}

extension SearchMainCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchInnerCell.identifier, for: indexPath) as? SearchInnerCell else {
            return UICollectionViewCell()
        }
        guard let image = UIImage(named: "welcomeScreenBackgroundImage") else {return UICollectionViewCell()}
        cell.configure(withImage: image , withTitle: "Hello", withRating: 12)
        return cell
    }
}


extension SearchMainCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.minimumLineSpacing = 20
//        }
        return CGSize(width: frame.size.width / 2.5 , height: frame.size.height / 3)
    }
}


