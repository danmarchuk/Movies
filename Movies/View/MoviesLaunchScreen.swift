//
//  MoviesLaunchScreen.swift
//  Movies
//
//  Created by Данік on 25/08/2023.
//

import Foundation
import UIKit
import SnapKit

@IBDesignable
final class MoviesLaunchScreen: UIView {
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    let tmdbImage = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "tmdbLaunchImage")
    }
    
    func setupView() {
        backgroundColor = K.launchScreenBlue
        addSubview(tmdbImage)
        
        tmdbImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.width.equalTo(280)
            make.height.equalTo(35)
        }
        
    }
    
    
}
