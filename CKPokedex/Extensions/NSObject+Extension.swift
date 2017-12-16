//
//  NSObject+Extension.swift
//  CKPokedex
//
//  Created by Christopher Brandon Karani on 28/11/2017.
//  Copyright © 2017 Christopher Brandon Karani. All rights reserved.
//

import IGListKit
import RealmSwift

// MARK: - IGListDiffable
extension NSObject: ListDiffable {
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
    
}

//extension Object: ListDiffable {
//    public func diffIdentifier() -> NSObjectProtocol {
//        return self
//    }
//
//    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
//        return isEqual(object)
//    }
//}
//
//extension Results : ListDiffable {
//    public func diffIdentifier() -> NSObjectProtocol {
//        return self
//    }
//
//    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
//        return isEqual(object)
//    }
//}

