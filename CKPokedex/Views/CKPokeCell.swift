//
//  CKPokeCell.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 17/11/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import UIKit
import SnapKit


enum PokeCellDataType {
    case name
    case id
    
    func returnStringRepresentation() -> String {
        switch self {
        case .name:
            return "Name: "
        case .id:
            return "ID: "
        }
    }
}

extension UILabel {
    
}

class CKPokeCell: UICollectionViewCell {
    
    
    let pokemonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var nameLabel : ValueLabel = {
        let label = ValueLabel(.name)
        return label
    }()
    
    var idLabel: ValueLabel = {
        let label = ValueLabel(.id)
        return label
    }()
    
    
    
    

    func setup(){
        contentView.addSubview(nameLabel)
        contentView.addSubview(idLabel)
        contentView.addSubview(pokemonImage)
        
        pokemonImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        idLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pokemonImage.snp.bottom).offset(4)
            make.left.equalTo(pokemonImage.snp.left)
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(idLabel.snp.bottom).offset(4)
            make.left.equalTo(idLabel.snp.left)
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
