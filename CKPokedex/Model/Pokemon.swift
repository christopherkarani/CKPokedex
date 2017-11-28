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
    var infomation : PokemonData? {
        didSet {
            let homeController = HomeController(networkService: PokemonNetwork())
            homeController.reloadAdapter()
        }
    }
    let networkService : NetworkService = PokemonNetwork()
    
    init(name: String, urlString: String) {
        self.name = name
        self.urlString = urlString
        super.init()
        networkService.fetchPokemonData(with: urlString, completion: { [weak self] (data) in
            self?.infomation = data
        })

    }
}

