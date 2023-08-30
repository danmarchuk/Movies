//
//  WelcomeScreen.swift
//  Movies
//
//  Created by Данік on 25/08/2023.
//

import Foundation
import UIKit
import SnapKit

@IBDesignable
final class WelcomeScreen: UIView {
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let backgroundImage = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "welcomeScreenBackgroundImage")
    }
    
    
    let welcomeLabel = UILabel().apply {
        $0.text = "Welcome."
        $0.font = UIFont(name: "OpenSans-ExtraBold", size: 42)
        $0.textColor = .white
    }
    
    let descriptionLabel = UILabel().apply {
        $0.text = "Millions of movies, TV shows and people to discover. "
        $0.font = UIFont(name: "OpenSans-Regular", size: 24)
        $0.textColor = .white
        $0.numberOfLines = 2
    }
    
    let userNameLabel = UILabel().apply {
        $0.text = "User Name"
        $0.font = UIFont(name: "OpenSans-SemiBold", size: 14)
        $0.textColor = .white
    }
    
    let userNameTextField = UITextField().apply {
        $0.font = UIFont(name: "OpenSans-SemiBold", size: 14)
        $0.textColor = .black
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
    }
    
    let passwordLabel = UILabel().apply {
        $0.text = "Password"
        $0.font = UIFont(name: "OpenSans-SemiBold", size: 14)
        $0.textColor = .white
    }
    
    let passwordTextField = UITextField().apply {
        $0.font = UIFont(name: "OpenSans-SemiBold", size: 14)
        $0.textColor = .black
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.isSecureTextEntry = true
    }
    
    let loginButtton = UIButton().apply {
        $0.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: 18)
        $0.setTitle("Log In", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = K.loginButtonBlue
        $0.layer.cornerRadius = 5
    }
    
    let signUpButton = UIButton().apply {
        $0.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: 20)
        $0.setTitle("Sign up", for: .normal)
        $0.setTitleColor(K.loginButtonBlue, for: .normal)
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 5
    }
    
    let remindMeLaterButton = UIButton().apply {
        $0.setTitle("Remind me later", for: .normal)
        $0.titleLabel?.font = UIFont(name: "OpenSans-Regular", size: 18)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 5
    }
    
    func addPaddingToTextField(_ textField: UITextField, padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    
    func setupView() {
        let scrollView = UIScrollView()
        let contentView = UIView()
        let views = [ welcomeLabel, descriptionLabel, userNameLabel, userNameTextField, passwordLabel, passwordTextField, loginButtton, signUpButton, remindMeLaterButton]
        
        addSubview(backgroundImage)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        addPaddingToTextField(userNameTextField, padding: 8)
        addPaddingToTextField(passwordTextField, padding: 8)
        
        views.forEach {
            contentView.addSubview($0)
        }
        
        // Scroll view setup
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.25)
            make.left.equalToSuperview().offset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
        }
        
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)

        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
        
        loginButtton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(48)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButtton.snp.bottom).offset(84)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
        
        remindMeLaterButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(34)
            make.bottom.equalTo(contentView).offset(-16)  // This sets the content size of the scroll view
        }
    }
}


