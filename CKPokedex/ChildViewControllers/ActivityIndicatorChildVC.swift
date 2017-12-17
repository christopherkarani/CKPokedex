//
//  ActivityIndicatorChildVC.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 17/12/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import UIKit

protocol UIIndicatorViewService {
    var indicator: UIActivityIndicatorView { get }
}
class PresenterView: UIView, UIIndicatorViewService {
    var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.attributedText = NSAttributedString(string: "Loading...", attributes: [.font : UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white])
        return label
    }()
    
    func setup() {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)

        addSubview(visualEffectView)
        visualEffectView.contentView.addSubview(indicator)
        visualEffectView.contentView.addSubview(textLabel)
        
        print("Number of views in visual EffectsView: ", visualEffectView.subviews.count)
        

        
        
        visualEffectView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(indicator.snp.bottom).inset(5)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        print("Number of views inside PresenterView: ", subviews.count)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ActivityIndicatorChildVC: UIViewController {

    var presenterView : PresenterView!
    override func viewDidLoad() {
        setup()
        
        view.backgroundColor = .clear
        
    }
    
    func setup() {
        presenterView = PresenterView(frame: .zero)
        view.addSubview(presenterView)
        
        presenterView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
    }
}
















