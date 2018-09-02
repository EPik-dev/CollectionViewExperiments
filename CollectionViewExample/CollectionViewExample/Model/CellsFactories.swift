//
//  CellsFactory.swift
//  CollectionViewExample
//
//  Created by Eldar Pikunov on 01/09/2018.
//  Copyright © 2018 EPik-dev. All rights reserved.
//

import UIKit

enum CellType {
    case simple
}

protocol CellsFactory {
    func makeCell(forType type: CellType) -> ConfigurableCell&AnyObject
    func makeCellViewModel(forType type: CellType) -> CellViewModel
}
