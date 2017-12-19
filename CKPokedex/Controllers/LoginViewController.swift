//
//  LoginViewController.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 17/12/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import UIKit
import RealmSwift
import Sukari


class LoginViewController: UIViewController {
    

    
    var stackViewHeight: CGFloat = 250
    
    
    let emailTextField = UITextField().this {
        $0.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.init(white: 0.70, alpha: 0.90)])
    }
    
    let passwordTextField = UITextField().this {
        $0.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.init(white: 0.70, alpha: 0.90)])
        $0.textColor = .white
        $0.isSecureTextEntry = true
    }
    
    
    let urlTextField = UITextField().this {
        $0.attributedPlaceholder =  NSAttributedString(string: "Url", attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.init(white: 0.70, alpha: 0.90)])
        $0.textColor = .white
    }
    
    lazy var signInButton = UIButton(type: .system).this { [weak self] in
        $0.setTitle("Sign In", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.backgroundColor = UIColor(r: 179, g: 62, b: 114)
        $0.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 5
    }
    
    var emailTextFieldSeperatorLine : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var urlTextFieldSeperatorLine : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    
    lazy var stackView : UIStackView = { [weak self] in
        guard let strongSelf = self else { return UIStackView() }
        var stack = UIStackView(arrangedSubviews: [strongSelf.emailTextField, strongSelf.urlTextField, strongSelf.passwordTextField, strongSelf.signInButton])
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let loginSpalshImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "pikachu")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let loginSplashLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "pokedex")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    
    var indicator: ActivityIndicatorChildVC?
    
    func addIndicator() {
        indicator = ActivityIndicatorChildVC(nibName: nil, bundle: nil)
        guard indicator != nil else { return }
        add(indicator!)
    }
    
    @objc func handleSignIn() {
        guard let user = emailTextField.text, let password = passwordTextField.text, let urlString = urlTextField.text else {
            print("Email or Password Error")
            return
        }
        guard !(user.isEmpty), !(password.isEmpty), !(urlString.isEmpty)  else {
            print("EmailTextField or Password is empty")
            return
        }
        guard let url = URL(string: urlString) else {
            print("URL error")
            return
        }
        
        addIndicator()
        
        let credentials = SyncCredentials.usernamePassword(username: user, password: password)
        SyncUser.logIn(with: credentials, server: url) { [weak self ] (user, error) in
            if error != nil {
                print("Error")
                self?.indicator?.remove()
                return
            }
            let sync = SyncConfiguration.init(user: user!, realmURL: url)
            let config =  Realm.Configuration(syncConfiguration: sync)
            let realm = try! Realm(configuration: config)
            Database.shared.realmDatabase = realm
            UserDefaults.standard.setLoggedInState(true)
            self?.indicator?.remove()
            
            self?.dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupSubviews()
    }
    
    func setupSubviews() {
        view.addSubview(stackView)
        view.addSubview(loginSplashLogo)
        view.addSubview(loginSpalshImage)
        
        stackView.addSubview(emailTextFieldSeperatorLine)
        stackView.addSubview(urlTextFieldSeperatorLine)
        
        emailTextFieldSeperatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }
        
        urlTextFieldSeperatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(urlTextField.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }

        
        loginSplashLogo.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        
        loginSpalshImage.snp.makeConstraints { (make) in
            make.top.equalTo(loginSplashLogo.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginSpalshImage.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(30)
            make.height.equalTo(stackViewHeight)
        }
    }
    
    func setupViewController() {
        
        view.backgroundColor = UIColor(r: 55, g: 70, b: 125)
    }
}
