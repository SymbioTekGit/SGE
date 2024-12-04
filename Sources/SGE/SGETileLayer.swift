//
//  SGETileLayer.swift
//  SwiftGameEngine
//
//  Created by Alvin Heib on 24/11/2024.
//

import SpriteKit

class SGETileLayer: NSObject {
    var cols: Int
    var rows: Int
    var gids: [[Int]]
    var tileset: SGETileSet
    var node: SKNode
    var tiles: [[SGETileNode?]]
    
    subscript(col: Int, row: Int) -> Int {
        get {
            return get(col: col, row: row)
        }
        set {
            set(col: col, row: row, gid: newValue)
        }
    }
    
    override var description: String {
        var str = "SGETileLayer: cols = \(cols) rows = \(rows)\n\t\(tileset)\t"
        for row in 0...rows-1 {
            for col in 0...cols-1 {
                let gid = gids[rows - row - 1][col]
                if gid == 0 {
                    str += "   "
                } else {
                    str += String(format:"%02X", gids[rows - row - 1][col]) + " "
                }
            }
            str += "\n\t"
        }
        return str
    }
    
    init(name: String = "tilelayer", cols: Int = 40, rows: Int = 25, tileset: SGETileSet) {
        self.cols = cols
        self.rows = rows
        self.gids = Array(repeating: Array(repeating: 0, count: cols), count: rows)
        self.tileset = tileset
        self.node = SKNode()
        self.tiles = Array(repeating: Array(repeating: nil, count: cols), count: rows)
        super.init()
        
        node.name = name
        node.position = .zero
        node.zPosition = -10
    }
    
    func reset(cols: Int = 40, rows: Int = 25, gids: [Int] = []) {
        self.cols = cols
        self.rows = rows
        self.gids = Array(repeating: Array(repeating: 0, count: cols), count: rows)
        self.tiles = Array(repeating: Array(repeating: nil, count: cols), count: rows)
        node.removeAllChildren()
        
        var col = 0
        var row = 0
        for gid in gids {
            set(col: col, row: row, gid: gid)
            
            col += 1
            if col >= cols {
                col = 0
                row += 1
                if row >= rows {
                    return
                }
            }
        }
    }
    
    func getCoord(x: Int, y: Int) -> (col: Int, row: Int) {
        return tileset.pos2coord(pos: CGPoint(x: x, y: y))
    }
    
    func get(col: Int, row: Int) -> Int {
        return gids[row][col]
    }
    
    func set(col: Int, row: Int, gid: Int) {
        let tile = SGETileNode(x: col * tileset.tilewidth, y: row * tileset.tileheight, gid: gid, tileset: tileset)
        node.addChild(tile)
        tiles[row][col] = tile
        
        gids[row][col] = gid
    }
    
    func rem(col: Int, row: Int) {
        if let tile = tiles[row][col] {
            tile.removeFromParent()
            tiles[row][col] = nil
            
            gids[row][col] = 0
        }
    }
    
    func update(col: Int, row: Int, gid: Int) {
        if let tile = tiles[row][col] {
            tile.update(gid: gid)
        } else {
            let tile = SGETileNode(x: col * tileset.tilewidth, y: row * tileset.tileheight, gid: gid, tileset: tileset)
            node.addChild(tile)
            tiles[row][col] = tile
        }
        gids[row][col] = gid
    }
    
    func move(col: Int, row: Int, dx: Int, dy: Int) {
        if let tile = tiles[row][col] {
            rem(col: col + dx, row: row + dy)
            
            tiles[row + dy][col + dx] = tile
            tiles[row][col] = nil
            tile.move(x: (col + dx) * tileset.tilewidth, y: (row + dy) * tileset.tileheight)
            
            gids[row + dy][col + dx] = gids[row][col]
            gids[row][col] = 0
        }
    }
}
