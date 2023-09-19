//
//  FuncManager.swift
//  Movies
//
//  Created by Данік on 19/09/2023.
//

import Foundation
import UIKit
import SnapKit

struct FuncManager {
    static func createCustomButton(withImage image: UIImage, withText text: String) -> UIButton {
        let button = UIButton()
        
        // Set button properties
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.borderColor = K.movieScreenBorderColor
        
        // Create an image view
        let imageView = UIImageView(image: image) // Replace with your image name
        imageView.contentMode = .scaleAspectFit
        
        // Create a label for text
        let label = UILabel().apply{
            $0.text = text
            $0.textAlignment = .center
            $0.textColor = K.movieScreenDarkBlueTextColor
            $0.font = UIFont(name: "OpenSans-Regular", size: 14)
        }
        // Create a vertical stack view for image and label
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        // Add the stack view to the button
        button.addSubview(stackView)
        
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        
        // Configure constraints for the stack view within the button using SnapKit
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalTo(button).offset(10)
            make.trailing.equalTo(button).offset(-10)
        }
        
        return button
    }
}
