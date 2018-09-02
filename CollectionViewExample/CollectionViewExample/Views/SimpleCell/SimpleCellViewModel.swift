//
//  SimpleCellViewModel.swift
//  CollectionViewExample
//
//  Created by Eldar Pikunov on 01/09/2018.
//  Copyright © 2018 EPik-dev. All rights reserved.
//

import Foundation

struct SimpleCellViewModel: CellViewModel {
    var reusableCellId: String {
        return "SimpleCellID"
    }
    
    var userName: String
    var avatarName: String
}
