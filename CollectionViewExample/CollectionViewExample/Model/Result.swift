//
//  Result.swift
//  CollectionViewExample
//
//  Created by Eldar Pikunov on 01/09/2018.
//  Copyright © 2018 EPik-dev. All rights reserved.
//

import Foundation

enum Result<T, ErrorT> {
    case success(T)
    case failed(ErrorT)
}
