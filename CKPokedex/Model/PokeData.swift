//
//  PokeData.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 28/11/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

struct PokemonData : JSONDecodable {
     init(json: JSON) throws {
        name = json["name"].stringValue
        id = json["id"].stringValue
        spriteUrlString = json["sprites"]["front_default"].stringValue
    }
    
    var name: String
    var id: String
    var spriteUrlString: String
}
