//
//  NSSet.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/19.
//

import Foundation

extension NSSet {
    func toArray<T: Hashable>() -> [T] {
        Array(self as! Set<T>)
    }
}
