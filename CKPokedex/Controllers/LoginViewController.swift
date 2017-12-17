//
//  LoginViewController.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 17/12/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import UIKit
import RealmSwift


class LoginViewController: UIViewController {
    

    
    var stackViewHeight: CGFloat = 250
    
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.init(white: 0.70, alpha: 0.90)])
        return tf
    }()
    
    let passwordTextField : UITextField = {
        let tf = UITextField()
        //tf.placeholder = "Password"
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.init(white: 0.70, alpha: 0.90)])
        tf.textColor = .white
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let urlTextField : UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Url", attributes: [.font : UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.init(white: 0.70, alpha: 0.90)])
        tf.textColor = .white
        return tf
    }()
    
    lazy var signInButton: UIButton = { [weak self] in
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(r: 179, g: 62, b: 114)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
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
        guard !(user.isEmpty), !(password.isEmpty), !(urlString.isEmpty), let url = URL(string: urlString) else {
            print("EmailTextField or Password is empty")
            return
        }
        
        addIndicator()
        
        let credentials = SyncCredentials.usernamePassword(username: user, password: password)
        SyncUser.logIn(with: credentials, server: url) { [weak self ] (user, error) in
            if error != nil {
                print("Error")
                //self?.indicator?.remove()
                return
            }
            
            UserDefaults.standard.setLoggedInState(true)
            //self?.indicator?.remove()
            
        }
    }
    
    let databaseService: DatabaseService
    
    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
