//
//  SGEObjectLayer.swift
//  SwiftGameEngine
//
//  Created by Alvin Heib on 01/12/2024.
//

import SpriteKit

class SGEObjectLayer: NSObject {
    static var nextId: Int = 1
    var datas: [SGEObject]
    var tileset: SGETileSet
    var node: SKNode
    
    subscript(index: Int) -> SGEObject {
        get {
            return datas[index]
        }
        set {
            set(newValue)
        }
    }
    
    override var description: String {
        return "SGETileObjectLayer: count = \(datas.count)\n\t\(tileset)\n\t\(datas)"
    }
    
    init(name: String, tileset: SGETileSet) {
        SGEObjectLayer.nextId = 1
        self.datas = []
        self.tileset = tileset
        self.node = SKNode()
        super.init()
        
        node.name = name
        node.position = .zero
        node.zPosition = 0
    }
    
    func reset(_ datas: [SGEObject] = []) {
        SGEObjectLayer.nextId = 1
        self.datas = []
        node.removeAllChildren()
        
        for data in datas {
            set(data)
        }
    }
    
    func getIndex(id: Int) -> Int? {
        if let index = datas.firstIndex(where: { $0.id == id }) {
            return index
        }
        return nil
    }
    
    func get(id: Int) -> SGEObject? {
        if let index = getIndex(id: id) {
            return datas[index]
        }
        return nil
    }
    
    func getIds(type: Int) -> [Int] {
        return datas.filter({ $0.type == type }).map({ $0.id })
    }
    
    func getIndex(x: Int, y: Int) -> Int? {
        if let index = datas.firstIndex(where: { (x >= $0.x) && (x < $0.x + tileset.tilewidth) && (y >= $0.y) && (y < $0.y + tileset.tileheight) }) {
            return index
        }
        
        return nil
    }
    
    func get(x: Int, y: Int) -> SGEObject? {
        if let index = getIndex(x: x, y: y) {
            return datas[index]
        }
        
        return nil
    }
    
    func getId(col: Int, row: Int) -> Int? {
        let pos = tileset.coord2pos(col: col, row: row)
        if let index = getIndex(x: Int(pos.x), y: Int(pos.y)) {
            return datas[index].id
        }
        return nil
    }

    func getType(x: Int, y: Int) -> Int {
        if let index = getIndex(x: x, y: y) {
            return datas[index].type
        }
        
        return 0
    }
    
    func set(_ obj: SGEObject) {
        datas.append(obj)
        
        let tile = SGETileNode(x: obj.x, y: obj.y, gid: obj.gid, tileset: tileset)
        node.addChild(tile)
        
        SGEObjectLayer.nextId += 1
    }
    
    func set(id: Int = SGEObjectLayer.nextId, type: Int, x: Int, y: Int, gid: Int) {
        let obj = SGEObject(id: id, type: type, x: x, y: y, gid: gid)
        set(obj)
    }
    
    func rem(id: Int) {
        if let index = getIndex(id: id) {
            node.children[index].removeFromParent()
            datas.remove(at: index)
        }
    }
    
    func move(id: Int, dx: Int, dy: Int) {
        if let index = getIndex(id: id) {
            datas[index].x += dx
            datas[index].y += dy
            node.children[index].position = CGPoint(x: datas[index].x, y: datas[index].y)
        }
    }
    
    func update(id: Int, gid: Int) {
        if let index = getIndex(id: id) {
            datas[index].gid = gid
            (node.children[index] as! SGETileNode).update(gid: gid)
        }
    }
}
