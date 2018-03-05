//
//  main.swift
//  problem01
//
//  Created by Student on 2018. 02. 25..
//  Copyright © 2018. Student. All rights reserved.
//

import Foundation

class List<T> {
    var value: T
    var next: List<T>?
    
    convenience init?(_ values: T...) {
        self.init(Array(values))
    }
    
    init?(_ values: [T]) {
        guard let first = values.first else {
            return nil
        }
        value = first
        next = List(Array(values.suffix(from: 1)))
    }
}

extension List{
    var last : T?{
        guard value != nil else{
            return nil
        }
        guard next != nil else{
            return value
        }
        return next!.last
    }
}

extension List {
    var pennultimate: T? {
        guard next != nil else{
            return nil
        }
        guard next?.next != nil else{
            return value
        }
        return next?.pennultimate
    }
}

extension List {
    subscript(index: Int) -> T? {
        get{
            guard index != 0 else{
                return value
            }
            var actual = self
            for _ in 0...index-1{
                actual = actual.next!
            }
            return actual.value
        }
    }
}

extension List {
    var length: Int {
        var count : Int = 0
        var actual = self
        while (actual != nil){
            count+=1
            guard actual.next != nil else {
                return count
            }
            actual = actual.next!
        }
        return count
    }
}

let res : Int? = List(1, 1, 2, 3, 5, 8)?.last
let res2 : Int? = List(1, 1, 2, 3, 5, 8)?.pennultimate
let list = List(1, 1, 2, 3, 5, 8)
print(list?.length)

