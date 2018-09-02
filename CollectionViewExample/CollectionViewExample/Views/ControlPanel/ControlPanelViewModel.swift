//
//  ControlPanelViewModel.swift
//  CollectionViewExample
//
//  Created by Eldar Pikunov on 02/09/2018.
//  Copyright © 2018 EPik-dev. All rights reserved.
//

import Foundation

protocol ControlPanelViewModelOutput {
    var scrollDirection: Box<ControlPanelViewModel.ScrollDirection> { get }
    
    var itemWidth: Box<Int> { get }
    var itemHeight: Box<Int> { get }
}

class ControlPanelViewModel: ControlPanelViewModelOutput {
    enum ScrollDirection: Int {
        case vertical
        case horizontal
    }
    
    var scrollDirection: Box<ScrollDirection> {
        return Box<ScrollDirection>(mutableBox: _scrollOrientation)
    }
    
    var itemWidth: Box<Int> {
        return Box<Int>(mutableBox: _itemWidth)
    }
    var itemHeight: Box<Int> {
        return Box<Int>(mutableBox: _itemHeight)
    }
    
    var _scrollOrientation = MutableBox<ScrollDirection>(value: .vertical)
    var _itemWidth = MutableBox<Int>(value: 70)
    var _itemHeight = MutableBox<Int>(value: 70)
}
