//
//  Pokemon.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 28/11/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import Foundation
import TRON


class Pokemon: NSObject {
    var name: String
    var urlString : String
    var infomation : PokemonData?
    let networkService : NetworkService = PokemonNetwork()
    
    init(name: String, urlString: String) {
        self.name = name
        self.urlString = urlString
        let path = String.init(describing: urlString.prefix(34))
        
        let indexString = self.urlString.replacingOccurrences(of: path, with: "")
        super.init()
        networkService.fetchPokemonData(with: indexString, completion: { [weak self] (data) in
            
            self?.infomation = data
        })

    }
}


extension String {
    
}
