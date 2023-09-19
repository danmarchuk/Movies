//
//  ActorCell.swift
//  Movies
//
//  Created by Данік on 19/09/2023.
//

import Foundation

class ActorCell: UICollectionViewCell {
    static let identifier = "ActorCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    let photo = UIImageView().apply {
        $0.image = UIImage(named: "tomHiddlestonPhoto")
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
    }
    
    
//    func configure(withMovie movie: Movie) {
//        dateAndSourceLabel.text = dateAndSource
//        titleLabel.text = article.title
//        let placeholderImage = UIImage(named: "16and9")
//        imageView.kf.setImage(with: URL(string: article.pictureLink), placeholder: placeholderImage)
//        bookmarkButton.tintColor = article.isSaved ? .red : .white
//    }
    
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
            make.width.equalTo(UIScreen.main.bounds.width / 4)
        }
        
        nameAndSurnameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(photo.snp.right).offset(16)
        }
        
        characterNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameAndSurnameLabel.snp.bottom).offset(4)
            make.left.equalTo(nameAndSurnameLabel.snp.right).offset(16)
            make.right.equalToSuperview()
        }
    }
}
