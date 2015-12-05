//
//  MapNode.swift
//  Data Structures
//
//  Created by Ezekiel Elin on 12/5/15.
//

import Foundation

class MapNode {
    var key: Int?
    var value: Int?
    
    var (_left, _right, _parent): (MapNode?, MapNode?, MapNode?)
    
    var left: MapNode {
        get {
            if let left = self._left {
                return left
            } else {
                return self
            }
        }
        set(node) {
            self._left = node
        }
    }
    var right: MapNode {
        get {
            if let right = self._right {
                return right
            } else {
                return self
            }
        }
        set(node) {
            self._right = node
        }
    }
    var parent: MapNode {
        get {
            if let parent = self._parent {
                return parent
            } else {
                return self
            }
        }
        set(node) {
            self._parent = node
        }
    }
    
    var height: Int
    
    init() {
        height = -1;
    }
    
    init(key k: Int, value v: Int, left l: MapNode, right r: MapNode, parent p: MapNode) {
        key = k;
        value = v;
        _left = l;
        _right = r;
        _parent = p;
        height = 0;
    }
}