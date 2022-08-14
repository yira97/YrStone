//
//  String.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/08/27.
//

import Foundation

extension String {
    var isNotEmpty: Bool {
        get {
            !self.isEmpty
        }
    }
    
    var stableHash: UInt64 {
        get {
            var result = UInt64 (5381)
            let buf = [UInt8](self.utf8)
            for b in buf {
                result = 127 * (result & 0x00ffffffffffffff) + UInt64(b)
            }
            return result
        }
     }
    
    var hashedRGB: (Double, Double, Double) {
        let hash = self.stableHash
        let colorNum = hash % (256*256*256)
        let red = colorNum >> 16
        let green = (colorNum & 0x00FF00) >> 8
        let blue = (colorNum & 0x0000FF)
        return (Double(red), Double(green), Double(blue))
    }
}
