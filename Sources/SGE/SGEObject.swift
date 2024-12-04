//
//  SGEObject.swift
//  SwiftGameEngine
//
//  Created by Alvin Heib on 01/12/2024.
//

import Foundation

struct SGEObject {
    var id: Int
    var type: Int
    var x: Int
    var y: Int
    var gid: Int
    
    var description: String {
       return "SGEObject: id: \(id) type = \(type) x = \(x) y = \(y) gid = \(gid)\n"
    }
    
    var cgPoint: CGPoint {
        return CGPoint(x: x, y: y)
    }
}
