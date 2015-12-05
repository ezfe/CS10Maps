//
//  MapADT.swift
//  Data Structures
//
//  Created by Prasad Jayanti on 12/6/15
//  Purpose: Map ADT where key and value are integers (for Lab 5 of CS 10)
//
//  Swiftified by Ezekiel Elin on 12/5/15.
//  Copyright © 2015 Ezekiel Elin. All rights reserved.
//

import Foundation

protocol Map: CustomStringConvertible {
    // if key k is in the map, change its associated value to v and return false;
    // otherwise insert key k with v as its associated value and return true.
    func insert(k: Int, _ v: Int) -> Bool
    
    // if key k is the object with an associated value of v, return (true, v);
    // otherwise return (false, 0)
    func find(k: Int) -> RetVal
    
    // if key k is not in the object, return (false, 0);
    // otherwise, remove that key (along with its associated value v) and return (true, v)
    func delete(k: Int) -> RetVal
    
    // return the number of keys in the object
    func size() -> Int;
    
    // return a good string representation of the object that you can print
    // to figure out whether inserts and deletes are working properly
    var description: String {
        get
    }
}