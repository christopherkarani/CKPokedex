//
//  CKPokeCell.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 17/11/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import UIKit

class CKPokeCell: UICollectionViewCell {
    
    let pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "charmander")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
