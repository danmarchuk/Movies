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
    var segmentedControlElements: [String]? {
        didSet {
            segmentedControll.reloadData()
        }
    }
    
    static let identifier = "SearchMainCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        segmentedControll.reloadData()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        segmentedControll.reloadData()
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
    
    let innerHorizontalCollectionView = InnerHorizontalViewController()
    
    func configure(withTitle title: String, withContents contents: [Content]) {
        mainLabel.text = title
        // Assuming segmentedControl has a function to set titles, just an example
//        segmentedControlElements = withSegmentedControl // Set here
//        segmentedControll.reloadData()
        innerHorizontalCollectionView.contents = contents
        innerHorizontalCollectionView.collectionView.reloadData()
        segmentedControll.reloadData()
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
                
        backgroundColor = .white
        addSubview(innerHorizontalCollectionView.view)
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
        
        innerHorizontalCollectionView.view.snp.makeConstraints { make in
            make.top.equalTo(segmentedControll.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
}

extension SearchMainCell: LUNSegmentedControlDelegate, LUNSegmentedControlDataSource {
    func numberOfStates(in segmentedControl: LUNSegmentedControl!) -> Int {
        return segmentedControlElements?.count ?? 1
    }

    func segmentedControl(_ segmentedControl: LUNSegmentedControl!, titleForStateAt index: Int) -> String! {
        if let elements = segmentedControlElements, index < elements.count {
            return elements[index]
        }
        return "Default Title"
    }


    func segmentedControl(_ segmentedControl: LUNSegmentedControl!, gradientColorsForStateAt index: Int) -> [UIColor]! {
        return [K.gradientColorOne, K.gradientColorTwo]
    }

    func segmentedControl(_ segmentedControl: LUNSegmentedControl!, didChangeStateFromStateAt fromIndex: Int, toStateAt toIndex: Int) {
//        segmentedControl.textFont = UIFont(name: "OpenSans-Bold", size: 14)
        print("5")
        
    }
}
