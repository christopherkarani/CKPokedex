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

struct DatabaseManager: DatabaseService {
    var realmDatabase : Realm
}
