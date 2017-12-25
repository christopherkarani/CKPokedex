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
    
    let emailTextField = CKTextField(placeholder: "Email").this {
        $0.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    }
    let passwordTextField = CKTextField(placeholder: "Password").this {
        $0.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    }
    let urlTextField = CKTextField(placeholder: "Url").this {
        $0.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    }
    
    @objc fileprivate func handleTextInputChange() {
        var isFormValid : Bool = false
        let email = emailTextField.text.unwrap()
        let url = urlTextField.text.unwrap()
        let password = passwordTextField.text.unwrap()
        
        if !(email.isEmpty) && password.count >= 6 && !(url.isEmpty) {
            isFormValid = true
        }
        switch isFormValid {
        case true:
            signInButton.alpha = 1
            signInButton.isUserInteractionEnabled = true
            signInButton.backgroundColor = UIColor(r: 179, g: 62, b: 114)

        case false:
            signInButton.alpha = 0.5
            signInButton.isUserInteractionEnabled = false
        }
    }

    lazy var signInButton = UIButton(type: .system).this { [weak self] in
        $0.setTitle("Sign In", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.backgroundColor = UIColor(r: 179, g: 62, b: 114)
        $0.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 5
        $0.alpha = 0.5
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
    
    let loginSpalshImage = UIImageView().this {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = #imageLiteral(resourceName: "pikachu")
        $0.contentMode = .scaleAspectFit
    }
    
    let loginSplashLogo = UIImageView().this {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = #imageLiteral(resourceName: "pokedex")
        $0.contentMode = .scaleAspectFit
    }
    
    
    
    var indicator: ActivityIndicatorChildVC?
    
    func addIndicator() {
        
        indicator = ActivityIndicatorChildVC(nibName: nil, bundle: nil)
        guard indicator != nil else { return }
        add(indicator!)
    }
    
    @objc func handleSignIn() {
        let email = emailTextField.text.unwrap(debug: "Email TextFied Error")
        let password = passwordTextField.text.unwrap(debug: "Password TextField Error")
        let urlString = urlTextField.text.unwrap(debug: "Url TextField Error")
        
        guard !(email.isEmpty), !(password.isEmpty), !(urlString.isEmpty)  else {
            print("EmailTextField or Password is empty")
            return
        }
        guard let url = URL(string: urlString) else {
            print("URL error")
            return
        }

        addIndicator()
        
        let credentials = SyncCredentials.usernamePassword(username: email, password: password)
        SyncUser.logIn(with: credentials, server: url) { [weak self ] (user, error) in
//            if error != nil {
//                print("Error: ", error!)
//                self?.indicator?.remove()
//                self?.dismiss(animated: true, completion: nil);
//                return
//            }
//            let sync = SyncConfiguration.init(user: user!, realmURL: url)
//            let config =  Realm.Configuration(syncConfiguration: sync)
//            let realm = try! Realm(configuration: config)
//            Database.shared.realmDatabase = realm
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

        loginSplashLogo.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(100)
        }
        
        loginSpalshImage.snp.makeConstraints {
            $0.top.equalTo(loginSplashLogo.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(100)
            $0.width.equalTo(100)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginSpalshImage.snp.bottom).offset(10)
            $0.width.equalToSuperview().inset(30)
            $0.height.equalTo(stackViewHeight)
        }
    }
    
    func setupViewController() {
        
        view.backgroundColor = UIColor(r: 55, g: 70, b: 125)
    }
}
