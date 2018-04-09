//
//  Helper.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 6/4/18.
//  Copyright © 2018 Jared Perez Vega. All rights reserved.
//

import Foundation

final class Helper {
    
    private static func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        return AnyIterator {
            let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
            if next.hashValue != i { return nil }
            i += 1
            return next
        }
    }
    
    static func getArrayFromEnumCases<T: Hashable>(enumType: T.Type) -> [T] {
        var array: [T] = []
        for element in self.iterateEnum(T.self) {
            array.append(element)
        }
        return array
    }
    
    
    
}
