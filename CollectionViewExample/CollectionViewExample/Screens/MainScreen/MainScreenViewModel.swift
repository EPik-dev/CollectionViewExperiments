//
//  MainScreenViewModel.swift
//  CollectionViewExample
//
//  Created by Eldar Pikunov on 01/09/2018.
//  Copyright © 2018 EPik-dev. All rights reserved.
//

import Foundation

class MainScreenViewModel {
    func loadUsers() {
        usersService.loadUsers { result in
            
        }
    }
    
    private let usersService: UsersService = UsersService()
}
