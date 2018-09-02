//
//  MainScreenViewModel.swift
//  CollectionViewExample
//
//  Created by Eldar Pikunov on 01/09/2018.
//  Copyright © 2018 EPik-dev. All rights reserved.
//

import Foundation

class MainScreenViewModel {
 
    let controlPanelModel: ControlPanelViewModelOutput = ControlPanelViewModel()
    
    var usersList: Box<ListViewModel> {
        return Box<ListViewModel>(mutableBox: usersListViewModel)
    }
    
    func loadUsers() {
        usersService.loadUsers { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let users):
                strongSelf.usersListViewModel.value =  LinearListViewModel<User, SimpleCellViewModel>(sourceItems: users,
                                                                                                mapping: strongSelf.mapUser)
            case .failed(let error):
                print("An error occured \(error)")
            }
        }
    }
    
    private func mapUser(_ user: User) -> SimpleCellViewModel {
        let userName = "\(user.firstName) \(user.lastName)"
        return SimpleCellViewModel(userName: userName, avatarName: user.avatarName)
    }
    
    private var usersListViewModel = MutableBox<ListViewModel>(value: LinearListViewModel<User, SimpleCellViewModel>())
    private let usersService = UsersService()
}


