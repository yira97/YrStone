//
//  GeometryProxy.swift
//  YrStone
//
//  Created by Yiran Feng on 2022/09/02.
//

import SwiftUI

extension GeometryProxy {
    var minWidth: CGFloat {
        get {
            min(self.size.width, self.size.height)
        }
    }
    
    var maxWidth: CGFloat {
        get {
            max(self.size.width, self.size.height)
        }
    }
}
