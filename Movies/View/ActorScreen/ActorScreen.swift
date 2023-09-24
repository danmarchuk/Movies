//
//  ActorScreen.swift
//  Movies
//
//  Created by Данік on 20/09/2023.
//

import Foundation
import SnapKit

@IBDesignable
final class ActorScreen: UIView {
    
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
    
    let actorPhoto = UIImageView().apply {
        $0.image = UIImage(named: "actress")
        $0.clipsToBounds = false
        $0.contentMode = .scaleAspectFill
    }
    
    var actorNameLabel = UILabel().apply {
        $0.text = "Loki"
        $0.numberOfLines = 1
        $0.font = UIFont(name: "OpenSans-Semibold", size: 18)
        $0.textColor = K.movieScreenDarkBlueTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var jobLabel = UILabel().apply {
        $0.text = "Actor"
        $0.numberOfLines = 1
        $0.font = UIFont(name: "OpenSans-Light", size: 14)
        $0.textColor = K.movieScreenDarkBlueTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let biographyLabel = UILabel().apply {
        $0.text = "Gugulethu Sophia Mbatha-Raw MBE is an English actress, known for her role as Kelly in Black Mirror, Dido Elizabeth Belle in Belle, Noni Jean in Beyond the Lights, and Plumette in Beauty and the Beast."
        $0.font = UIFont(name: "OpenSans-Regular", size: 14)
        $0.numberOfLines = 7
        $0.textColor = K.movieScreenGray2
    }
    
    let knownForLabel = UILabel().apply {
        $0.text = "Known For"
        $0.numberOfLines = 1
        $0.font = UIFont(name: "OpenSans-Semibold", size: 18)
        $0.textColor = K.movieScreenDarkBlueTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var knownForController = KnownForHorizontalViewController()
    
    let actingLabel = UILabel().apply {
        $0.text = "Acting"
        $0.font = UIFont(name: "OpenSans-Semibold", size: 18)
        $0.textColor = K.movieScreenDarkBlueTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let seeAllActingButton = UIButton(type: .system).apply {
        $0.setTitle("See All", for: .normal)
        $0.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 14)
        $0.setTitleColor(K.seeAllColor, for: .normal)
        // Add more configurations if needed
        // E.g., $0.addTarget(self, action: #selector(yourFunction), for: .touchUpInside)
    }
    
    var actingVerticalController = ActingVerticalController()
    
    func configure(withActorInfo info: ActorFullInfo, withMovies movies: [ActingInfo]) {
        actorPhoto.sd_setImage(with: URL(string: info.imageUrl))
        actorNameLabel.text = info.nameAndSurname
        jobLabel.text = info.job
        biographyLabel.text = info.biography
        actingVerticalController.contents = movies
        actingVerticalController.collectionView.reloadData()
    }
    
    func setupView() {
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func setupConstraints() {
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
        
        let actorPhotoAspectRatio: CGFloat = 168.0 / 121.0  // Original height / Original width
        
        actorPhoto.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.width.equalTo(UIScreen.main.bounds.width / 3.3)
            make.height.equalTo(actorPhoto.snp.width).multipliedBy(actorPhotoAspectRatio)
        }
        
        actorNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(actorPhoto.snp.right).offset(16)
        }
        
        jobLabel.snp.makeConstraints { make in
            make.top.equalTo(actorNameLabel.snp.bottom).offset(4)
            make.left.equalTo(actorPhoto.snp.right).offset(16)
        }
        
        biographyLabel.snp.makeConstraints { make in
            make.top.equalTo(jobLabel.snp.bottom).offset(4)
            make.left.equalTo(actorPhoto.snp.right).offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        knownForLabel.snp.makeConstraints { make in
            make.top.equalTo(actorPhoto.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(16)
        }
        
        knownForController.view.snp.makeConstraints { make in
            make.top.equalTo(knownForLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        
        actingLabel.snp.makeConstraints { make in
            make.top.equalTo(knownForController.view.snp.bottom).offset(58)
            make.left.equalToSuperview().offset(16)
        }
        
        seeAllActingButton.snp.makeConstraints { make in
            make.top.equalTo(knownForController.view.snp.bottom).offset(58)
            make.right.equalToSuperview().inset(16)
        }
        let itemHeight: CGFloat = 52
        let totalItemsHeight = CGFloat(actingVerticalController.contents.count) * itemHeight
        
        actingVerticalController.view.snp.makeConstraints { make in
            make.top.equalTo(actingLabel.snp.bottom).offset(13)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
            make.height.equalTo(UIScreen.main.bounds.height / 3)
        }
    }
    
    func addSubviews() {
        // Add UIScrollView and ContentView
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        // Add other subviews to contentView
        contentView.addSubview(actorPhoto)
        contentView.addSubview(actorNameLabel)
        contentView.addSubview(jobLabel)
        contentView.addSubview(biographyLabel)
        contentView.addSubview(knownForLabel)
        contentView.addSubview(knownForController.view)
        contentView.addSubview(actingLabel)
        contentView.addSubview(seeAllActingButton)
        contentView.addSubview(actingVerticalController.view)
    }
}
