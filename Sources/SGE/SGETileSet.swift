//
//  SGETileSet.swift
//  SwiftGameEngine
//
//  Created by Alvin Heib on 24/11/2024.
//

import SpriteKit

class SGETileSet: NSObject {
    var firstgid: Int
    var tilewidth: Int
    var tileheight: Int
    var tiles: [CGImage]
    var tilecount: Int {
        return tiles.count
    }
    
    subscript(index: Int) -> CGImage {
        get {
            let id = index - firstgid
            return tiles[id]
        }
        set {
            let id = index - firstgid
            tiles[id] = newValue
        }
    }
    
    override var description: String {
        return "SGETileSet: tilewidth = \(tilewidth) tileheight = \(tileheight) firstgid = \(firstgid) tilecount = \(tilecount)\n"
    }
    
    init(tilewidth: Int, tileheight: Int, firstgid: Int = 1) {
        self.firstgid = firstgid
        self.tilewidth = tilewidth
        self.tileheight = tileheight
        self.tiles = []
    }
    
    func coord2pos(col: Int, row: Int) -> CGPoint {
        return CGPoint(x: col * tilewidth, y: row * tileheight)
    }
    
    func pos2coord(pos: CGPoint) -> (Int, Int) {
        let col = Int(pos.x / CGFloat(tilewidth))
        let row = Int(pos.y / CGFloat(tileheight))
        return (col, row)
    }
    
    func pos2coordCenter(pos: CGPoint) -> (Int, Int) {
        let col = Int((pos.x + CGFloat(tilewidth/2)) / CGFloat(tilewidth))
        let row = Int((pos.y + CGFloat(tileheight/2)) / CGFloat(tileheight))
        return (col, row)
    }
    
    func split(imageNamed: String, count: Int = -1) {
        let tex = SKTexture(imageNamed: imageNamed)
        let image = tex.cgImage()
        
        let cols = Int(image.width / tilewidth)
        let rows = Int(image.height / tileheight)
        let count = (count == -1 ? cols * rows : count)
        
        tiles = []
        var id = 0
        while id < count {
            let col = id % cols
            let row = Int(id / cols)
            let rect = CGRect(x: col * tilewidth, y: row * tileheight, width: tilewidth, height: tileheight)
            if let tile = image.cropping(to: rect) {
                tiles.append(tile)
            }
            id += 1
        }
    }
}
