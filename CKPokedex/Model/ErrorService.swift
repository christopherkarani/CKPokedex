//
//  ErrorService.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 27/11/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import TRON
import SwiftyJSON

protocol ErrorService {}

class PokemonError: ErrorService, JSONDecodable {
    required init(json: JSON) throws {
        print("We have hit an error:", json)
    }
    
}
