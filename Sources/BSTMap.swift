//
//  MapADT.swift
//  Data Structures
//
//  Created by Prasad Jayanti on 12/6/15
//  Purpose: Implements the interface in MyMapADT.java as a BST
//
//  Swiftified by Ezekiel Elin on 12/5/15.
//


import Foundation

public class BSTMap: Map {
    var n: Int // number of keys in the object
    var sentinel: MapNode // always present (even when n=0), with a height of -1
    var root: MapNode // if n==0, root=sentinel; otherwise root references BST's root MapNode
    
    init() {
        sentinel = MapNode()
        root = sentinel
        n = 0
    }
    
    func size() -> Int {
        return n
    }
    
    func find(k: Int) -> RetVal {
        let x = findHelper(k);
        if let val = x.value where x !== sentinel {
            return RetVal(found: true, value: val)
        } else {
            return RetVal(found: false, value: 0)
        }
    }
    
    // if key k is not in the map, returns null;
    // otherwise, returns a MapNode in the tree whose key is k
    private func findHelper(k: Int) -> MapNode {
        var x = root;
        while (x !== sentinel) && (k != x.key) {
            if (k < x.key){
                x = x.left
            } else {
                x = x.right
            }
        }
        return x;
    }
    
    func insert(k: Int, _ v: Int) -> Bool {
        if let z = insertHelper(k, v) {
            fixAfterInsert(z)
            return true
        } else {
            return false;
        }
    }
    
    // if k is in the map, changes the value associated with k to v and return null;
    // otherwise inserts a new MapNode whose key is k and value is v, and returns its reference
    func insertHelper(k: Int, _ v: Int) -> MapNode? {
        var x = root;
        var p = sentinel;
        
        while (x !== sentinel) && (k != x.key) {
            p = x;
            if (k < x.key) {
                x = x.left
            } else {
                x = x.right
            }
        }
        
        if (x !== sentinel) && (k == x.key) {
            x.value = v
            return nil
        } else {
            n += 1
            if (root === sentinel) {
                root = MapNode(key: k, value: v, left: sentinel, right: sentinel, parent: sentinel)
                return root
            } else {
                let z = MapNode(key: k, value: v, left: sentinel, right: sentinel, parent: p);
                if (k < p.key) {
                    p.left = z
                }
                else {
                    p.right = z
                }
                return z
            }
        }
    }
    
    // assumes z is a reference to a newly inserted MapNode;
    // fixes the heights of all MapNodes, starting from z's parent, all the way up to the root
    private func fixAfterInsert(y: MapNode) {
        var z = y
        var done = false
        while z !== root && !done {
            if (z.parent.height == z.height) {
                z.parent.height = 1 + z.height;
            } else {
                done = true;
            }
            z = z.parent;
        }
    }
    
    func delete(k: Int) -> RetVal {
        guard let z = deleteHelper(k) else {
            return RetVal(found: false, value: 0)
        }
        n -= 1
        fixDelete(z.node)
        return RetVal(found: true, value: z.value)
    }
    
    // If key k is not in the map, return null.
    // Otherwise, remove this key and return (z, v), where
    // v was the value associated with the removed key k, and
    // z is the parent of the MapNode physically spliced out
    // by the standard BST delete procedure
    internal func deleteHelper(k: Int) -> NodeValPair? {
        var (x, y, z): (MapNode, MapNode, MapNode)
        x = findHelper(k)
        if (x === sentinel) {
            return nil
        }
        let val = x.value
        z = x;
        if (x.left === sentinel) {
            y = x.right;
        } else if (x.right === sentinel) {
            y = x.left;
        } else {
            z = x.right;
            while (z.left !== sentinel) {
                z = z.left;
            }
            x.key = z.key;
            x.value = z.value;
            y = z.right;
        }
        y.parent = z.parent;
        if (z === root) {
            root = y;
        } else if (z.parent.left === z) {
            z.parent.left = y;
        } else {
            z.parent.right = y
        }
        if let val = val {
            return NodeValPair(node: z.parent, value: val)
        } else {
            assertionFailure("Unable to get value")
            return NodeValPair(node: z.parent, value: 0)
        }
    }
    
    // fixes height of MapNodes starting from z, all the way up to root
    internal func fixDelete(y: MapNode) {
        var z = y
        while z !== sentinel {
            if z.height > 1 + Swift.max(z.left.height, z.right.height) {
                z.height = z.height - 1;
                z = z.parent;
            } else {
                return
            }
        }
    }
    
    // convert the tree into a string (for printing the tree) unless the tree is too big
    // the string corresponds to the tree tilted by 90 degree counter-clockwise.
    public var description: String {
        get {
            if (n > 25) {
                return "Size is \(n), which is too large to print\n"
            } else if n == 0 {
                return "Empty Tree!\n"
            } else {
                return "(for each MapNode, its key and height are shown)\n\n\(toString(root, indent: "  "))"
            }
        }
    }
    
    // turn into string the subtree rooted at x, with leading blank spaces given by "indent"
    private func toString(x: MapNode, indent: String) -> String {
        if (x === sentinel) {
            return ""
        } else {
            let indented = "\(indent)      "
            return "\(toString(x.right, indent: indented))\(indent)(\(x.key!),\(x.height))\n\(toString(x.left, indent: indented))"
        }
    }
}