//
//  DatabaseService.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 15/12/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import Foundation
import RealmSwift

protocol DatabaseService {
    var realmDatabase : Realm { get }
}

extension DatabaseService {
    var realmDatabase : Realm {
        get {
            return try! Realm()
        }
    }
}

struct DatabaseManager: DatabaseService {
}


final class Database: DatabaseService {
    var realmDatabase : Realm = try! Realm()
}
