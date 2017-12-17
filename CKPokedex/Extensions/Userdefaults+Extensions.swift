//
//  Userdefaults+Extensions.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 18/12/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum LoggedInState: String {
        case loggedIn
    }
    
    func setLoggedInState(_ value: Bool) {
        set(value, forKey: LoggedInState.loggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: LoggedInState.loggedIn.rawValue)
    }
}
