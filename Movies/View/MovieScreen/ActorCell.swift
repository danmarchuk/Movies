//
//  ActorCell.swift
//  Movies
//
//  Created by Данік on 19/09/2023.
//

import Foundation
import SnapKit
import UIKit
import SDWebImage

final class ActorCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    let photo = UIImageView().apply {
        $0.image = UIImage(named: "welcomeScreenBackgroundImage")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = false // this needs to be true to see the rounded corners
    }
    
    let nameAndSurnameLabel = UILabel().apply {
        $0.text = "Tom Hiddleston"
        $0.font = UIFont(name: "OpenSans-Regular", size: 11)
        $0.textColor = K.movieScreenDarkBlueTextColor
    }
    
    let characterNameLabel = UILabel().apply {
        $0.text = "Amongus"
        $0.font = UIFont(name: "OpenSans-Regular", size: 10)
        $0.textColor = K.characterGrayTextColor
        $0.numberOfLines = 2
    }
    
    func configure(withActor actor: ActorShortInfo) {
        photo.sd_setImage(with: URL(string: actor.imageUrl))
        nameAndSurnameLabel.text = actor.nameAndSurname
        characterNameLabel.text = actor.character
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        addSubview(photo)
        addSubview(nameAndSurnameLabel)
        addSubview(characterNameLabel)
        
        photo.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 5.5)
        }
        
        nameAndSurnameLabel.snp.makeConstraints { make in
            make.top.equalTo(photo.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        characterNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameAndSurnameLabel.snp.bottom).offset(4)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
