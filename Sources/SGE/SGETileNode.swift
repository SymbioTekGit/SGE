//
//  SGE2DTable.swift
//  SwiftGameEngine
//
//  Created by Alvin Heib on 24/11/2024.
//

import SpriteKit

class SGETileNode: SKSpriteNode {
    var tileset: SGETileSet
    
    init(x: Int, y: Int, gid: Int, tileset: SGETileSet) {
        self.tileset = tileset
        
        let tex = SKTexture(cgImage: tileset[gid])
        tex.filteringMode = .nearest
        super.init(texture: tex, color: .red, size: tex.size())
        
        self.name = "\(gid)"
        self.position = CGPoint(x: x, y: y)
        self.anchorPoint = CGPoint(x: 0, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(gid: Int) {
        let tex = SKTexture(cgImage: tileset[gid])
        tex.filteringMode = .nearest
        
        self.texture = tex
        self.size = tex.size()
    }
    
    func move(x: Int, y: Int) {
        self.position = CGPoint(x: x, y: y)
    }
}
