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
    var realmDatabase : Realm? { get }
}

extension DatabaseService {
    
    
}

class DatabaseManager: DatabaseService {
    var realmDatabase : Realm?
    
    init() {
        let syncServerURL = URL(string: "http://localhost:9080")!
        let credentials = SyncCredentials.usernamePassword(username: "chrisbkarani@gmail.com", password: "milley0956")
        
        SyncUser.logIn(with: credentials, server: syncServerURL) { (user, error) in
            if error != nil {
                print(error!)
                return
            }
            let config = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user!, realmURL: syncServerURL))
            
            self.realmDatabase = try! Realm(configuration: config)
        }
    }
}
