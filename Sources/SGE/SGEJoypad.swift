//
//  SGEJoypad.swift
//  SwiftGameEngine
//
//  Created by Alvin Heib on 29/11/2024.
//

import SpriteKit

enum SGEKeyboardMask: UInt8 {
    case right      = 1
    case left       = 2
    case down       = 4
    case up         = 8
    case start      = 16
    case select     = 32
    case a          = 64
    case b          = 128
}

class SGEJoypad {
    var keyboardMask: [UInt16: SGEKeyboardMask] = [
        0x7C:   .right,     // rightArrow
        0x7B:   .left,      // leftArrow
        0x7D:   .down,      // downArrow
        0x7E:   .up,        // upArrow
        0x24:   .start,     // returnKey
        0x3C:   .select,    // rightShift
        0x31:   .a,         // space
        0x38:   .b          // shift
    ]
    var status: UInt8 = 0b00000000
    
    func reset() {
        status = 0
    }
    
    func isKeyDown(key: SGEKeyboardMask) -> Bool {
        return (status & key.rawValue == key.rawValue)
    }
    
    func isKeyUp(key: SGEKeyboardMask) -> Bool {
        return (~status & key.rawValue == key.rawValue)
    }
    
    func getDxDy() -> (Int, Int) {
        var dx = 0
        var dy = 0
        if isKeyDown(key: .right) {
            dx = 1
        }
        if isKeyDown(key: .left) {
            dx = -1
        }
        if isKeyDown(key: .up) {
            dy = 1
        }
        if isKeyDown(key: .down) {
            dy = -1
        }
        return (dx, dy)
    }
    
    func keyDown(keyCode: UInt16) {
        if let key = keyboardMask[keyCode] {
            status |= key.rawValue
        }
    }
    
    func keyUp(keyCode: UInt16) {
        if let key = keyboardMask[keyCode] {
            status &= ~(key.rawValue)
        }
    }
    
}
