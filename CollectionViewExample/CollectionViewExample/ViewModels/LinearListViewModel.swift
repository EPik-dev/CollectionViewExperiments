//
//  LinearListViewModel.swift
//  CollectionViewExample
//
//  Created by Eldar Pikunov on 02/09/2018.
//  Copyright © 2018 EPik-dev. All rights reserved.
//

import Foundation

protocol ListViewModel {
    var sectionsCount: Int { get }
    func itemsCount(forSection section: Int) -> Int
    func item(at index: Int, forSection section: Int) -> CellViewModel?
}

class LinearListViewModel<Source, Item: CellViewModel>: ListViewModel {
    
    typealias Mapping = ((Source) -> Item)
    
    init(sourceItems:[Source], mapping: Mapping) {
        items = sourceItems.compactMap { source -> Item in
            return mapping(source)
        }
    }
    
    init() {
    }
    
    func itemsCount(forSection section: Int) -> Int {
        return items.count
    }
    
    var sectionsCount: Int {
        return 1
    }
    
    func item(at index: Int, forSection section: Int) -> CellViewModel? {
        guard index >= 0, index < itemsCount(forSection: section) else {
            return nil
        }
        return items[index]
    }
    
    private var items: [Item] = []
}
