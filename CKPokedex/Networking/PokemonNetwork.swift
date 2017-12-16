//
//  PokemonNetwork.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 28/11/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import Foundation
import TRON

class PokemonNetwork: NetworkService {
     var tron : TRON = TRON(baseURL: "https://pokeapi.co/api/v2/")
}
