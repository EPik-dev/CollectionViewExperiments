//
//  Box.swift
//  CollectionViewExample
//
//  Created by Eldar Pikunov on 02/09/2018.
//  Copyright © 2018 EPik-dev. All rights reserved.
//

import Foundation

protocol Observable {
    associatedtype Value
    
    typealias ValueChanged = (Value)->Void
    
    var didChange: ValueChanged? { get set }
}


class MutableBox<T>: Observable {
    typealias Value = T
    var value: T {
        didSet {
            didChange?(value)
        }
    }
    
    var didChange: ValueChanged?
    
    init(value: T) {
        self.value = value
    }
}

class Box<T>: Observable {
    typealias Value = T
    
    var value: T {
        return mutableBox.value
    }
    
    var didChange: ValueChanged? {
        get {
            return mutableBox.didChange
        }
        set {
            mutableBox.didChange = newValue
        }
    }
    
    init(mutableBox: MutableBox<T>) {
        self.mutableBox = mutableBox
    }
    
    private var mutableBox:  MutableBox<T>
}
