//
//  MapADT.swift
//  Data Structures
//
//  Created by Prasad Jayanti on 12/6/15
//
//  Swiftified by Ezekiel Elin on 12/5/15.
//

import Foundation

public class AVLMap: BSTMap {
    
    override func delete(k: Int) -> RetVal {
        guard let z = deleteHelper(k) else {
            return RetVal(found: false, value: 0)
            
        }
        n -= 1
        fixDelete(z.node)
        return RetVal(found: true, value: z.value)
    }
    
    // once the delete operation splices out a node,
    // z is the deepest node whose height may be incorrect.
    // The method fixes the height of all nodes from z to root,
    // starting with z, and rebalancing as necessary.
    override func fixDelete(y: MapNode) {
        var z = y
        var h: Int
        while (z !== sentinel) {
            h = 1 + Swift.max(z.left.height, z.right.height)
            if isBalanced(z) {
                if (h == z.height) {
                    return
                } else {
                    z.height = h
                    z = z.parent
                }
            } else {
                let p = z.parent
                balance(z)
                z = p
            }
        }
    }
    
    override func insert(k: Int, _ v: Int) -> Bool {
        guard let z = insertHelper(k, v) else {
            return false
        }
        fixHeight(z)
        return true
    }
    
    // z is the node just inserted into the BST.
    // The method adjusts the heights of the nodes from z to the root,
    // starting from z's parent.  If imbalance is found at any node,
    // the tree is rebalanced.
    func fixHeight(y: MapNode) {
        var z = y
        var done = false
        while z !== root && !done {
            if (z.parent.height > z.height) {
                done = true
            }
            else {
                z.parent.height = z.height + 1
                if isBalanced(z.parent) {
                    z = z.parent
                } else {
                    balance(z.parent)
                    done = true
                }
            }
        }
    }
    
    // returns whether the AVL balance property is satisfied at the node z
    private func isBalanced(z: MapNode) -> Bool {
        return Swift.abs(z.left.height - z.right.height) < 2
    }
    
    // z is a non-sentinel node that is out of balance,
    // but the subtrees of z are all balanced.
    // The method rebalances the tree under z.
    private func balance(z: MapNode) {
        if z.right.height > z.left.height {
            if z.right.right.height > z.right.left.height {
                lRotate(z)
            } else {
                rRotate(z.right)
                lRotate(z)
            }
        }
        else {
            if z.left.left.height > z.left.right.height {
                rRotate(z)
            } else {
                lRotate(z.left)
                rRotate(z)
            }
        }
    }
    
    
    private func lRotate(z: MapNode) {
        let p = z.parent
        let y = z.right
        let α = z.left
        let β = y.left
        let γ = y.right
        
        sentinel.height = -1
        
        z.right = β
        z.height = 1 + Swift.max(α.height, β.height)
        y.left = z
        y.height = 1 + Swift.max(z.height, γ.height)
        
        z.parent = y
        β.parent = z
        y.parent = p
        if p === sentinel {
            root = y
        } else if p.left === z {
            p.left = y
        } else {
            p.right = y
        }
    }
    
    private func rRotate(z: MapNode) {
        let p = z.parent
        let y = z.left
        let β = y.right
        let γ = z.right
    
        sentinel.height = -1
        
        z.left = β
        z.height = 1 + Swift.max(β.height, γ.height)
        y.right = z
        y.height = 1 + Swift.max(z.height, γ.height)
        
        z.parent = y
        β.parent = z
        y.parent = p
        if p === sentinel {
            root = y
        } else if p.left === z {
            p.left = y
        } else {
            p.right = y;
        }
    }
    
}