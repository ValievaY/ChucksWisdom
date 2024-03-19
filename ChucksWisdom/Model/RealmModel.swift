//
//  RealmModel.swift
//  ChucksWisdom
//
//  Created by Apple Mac Air on 15.03.2024.
//

import Foundation
import RealmSwift

final class ValueModel: Object {
    
    @Persisted var value: String = ""
    
    override static func primaryKey() -> String? {
         return "value"
    }
}

final class Category: Object {
    
    @Persisted var category: String = ""
    @Persisted var value: List<ValueModel>
    
    override static func primaryKey() -> String? {
         return "category"
    }
}
