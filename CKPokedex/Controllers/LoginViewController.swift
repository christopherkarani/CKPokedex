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


class CKTextField: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.init(white: 0.70, alpha: 0.90)])
        borderStyle = .roundedRect
        backgroundColor = UIColor(white: 0, alpha: 0.20)
        textColor = .white
        autocapitalizationType = .none
        autocorrectionType = .no
        
        if placeholder.lowercased() == "password" {
            isSecureTextEntry = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LoginViewController: UIViewController {
    var stackViewHeight: CGFloat = 280
    
    let emailTextField = CKTextField(placeholder: "Email")
    let passwordTextField = CKTextField(placeholder: "Password")
    let urlTextField = CKTextField(placeholder: "Url")


    lazy var signInButton = UIButton(type: .system).this { [weak self] in
        $0.setTitle("Sign In", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.backgroundColor = UIColor(r: 179, g: 62, b: 114)
        $0.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 5
    }

    lazy var stackView : UIStackView = { [weak self] in
        guard let strongSelf = self else { return UIStackView() }
        var stack = UIStackView(arrangedSubviews: [strongSelf.emailTextField, strongSelf.urlTextField, strongSelf.passwordTextField, strongSelf.signInButton])
        stack.spacing = 15
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

        loginSplashLogo.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
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
