//
//  pokemon.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 25/11/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import Foundation
import IGListKit
import TRON
import SwiftyJSON
import RealmSwift
import RxSwift

class PokeCenter: NSObject, JSONDecodable{

    let databaseService : DatabaseService = DatabaseManager()
    func rx() {
        let schedular = SerialDispatchQueueScheduler(qos: .default)
        let subscription = Observable.just("RxSwift")
        let sub = subscription.subscribe { (event) in
            print(event)
        }
        Thread.sleep(forTimeInterval: 0.2)
    }
    var pokemon = [Pokemon]()
    
    
    required init(json: JSON) throws {
        let results = json["results"].arrayValue
        var items : [Pokemon] = []
   
        for data in results {
            let name = data["name"].stringValue
            let urlString = data["url"].stringValue
            let pokemon = Pokemon(name: name, urlString: urlString)

            items.append(pokemon)
        }
        pokemon = items
        super.init()
        //
        rx()
    }
    
    func configureRealm() {
     
    }
    
}





