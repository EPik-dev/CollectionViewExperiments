//
//  MainScreenViewController.swift
//  CollectionViewExample
//
//  Created by Eldar Pikunov on 01/09/2018.
//  Copyright © 2018 EPik-dev. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadUsers()
    }
    
    private var viewModel = MainScreenViewModel()
    private let factory: CellsFactory = MainScreenCellsFactory()
}


//extension MainScreenViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>)
//    }
//}

extension MainScreenViewController: UICollectionViewDelegate {
    
}

class MainScreenCellsFactory: CellsFactory {
    func makeCell(forType type: CellType) -> UICollectionViewCell {
        switch type {
        case .simple:
            return SimpleCell()
        }
    }
    
    func makeCellViewModel(forType type: CellType) -> CellViewModel {
        switch type {
        case .simple:
            return SimpleCellViewModel()
        }
    }
    
    
}
