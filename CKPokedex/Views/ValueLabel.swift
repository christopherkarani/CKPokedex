//
//  ValueLabel.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 27/11/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import UIKit

class ValueLabel: UILabel {
    
    var type      : PokeCellDataType
    var valueText : NSMutableString?
    
    func setup(_ text: String) {
        attributedText = setupAttributedString(withText: text)
    }
    
    init(_ valueType: PokeCellDataType) {
        type = valueType
        super.init(frame: .zero)
        
    }
    
    private func setupAttributedString(withText txt: String) -> NSAttributedString {
        let attributes = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
        let attributedString = NSMutableAttributedString(string: type.returnStringRepresentation(), attributes: attributes)
        
        let normalText = NSAttributedString(string: txt)
        attributedString.append(normalText)
        
        return attributedString
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
