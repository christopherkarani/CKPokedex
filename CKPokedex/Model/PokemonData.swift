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
import RealmSwift
import RxSwift
class PokemonData: Object, JSONDecodable {
    
   
    convenience required init(json: JSON) throws {
        self.init()
        name = json["name"].stringValue
        id = json["id"].stringValue
        spriteUrlString = json["sprites"]["front_default"].stringValue
    }
    
    @objc dynamic var name: String?
    @objc dynamic var id: String?
    @objc dynamic var spriteUrlString: String?
}


