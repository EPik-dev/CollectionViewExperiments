//
//  UsersService.swift
//  CollectionViewExample
//
//  Created by Eldar Pikunov on 01/09/2018.
//  Copyright © 2018 EPik-dev. All rights reserved.
//

import Foundation

class UsersService {

    typealias UsersListResult = Result<[User], Error>
    
    enum UserServiceError: Error {
        case noData
        case jsonParse
    }
    
    func loadUsers(completion: ((_ result: UsersListResult) -> Void)?) {
        let fileName = "users.json"
        loadFromFile(fileName: fileName, completion: completion)
    }

    private func loadFromFile(fileName: String, completion: ((_ result: UsersListResult) -> Void)?) {
        let decoder = JSONDecoder()
        guard let data = readDataFromFile(fileName: fileName) else {
            completion?(.failed(UserServiceError.noData))
            return
        }
        do {
            let users = try decoder.decode([User].self, from: data)
            completion?(.success(users))
        }
        catch {
            completion?(.failed(UserServiceError.jsonParse))
            return
        }
        
    }
    
    private func readDataFromFile(fileName: String) -> Data? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        }
        catch {
            return nil
        }
    }
}
