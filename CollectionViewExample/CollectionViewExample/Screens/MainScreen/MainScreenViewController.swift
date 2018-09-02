//
//  MainScreenViewController.swift
//  CollectionViewExample
//
//  Created by Eldar Pikunov on 01/09/2018.
//  Copyright © 2018 EPik-dev. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadUsers()
    }
    
    private func bindViewModel() {
        viewModel.usersList.didChange = { [weak self] value in
            guard let strongSelf = self else {
                return
            }
            strongSelf.collectionView?.reloadData()
        }
    }
    
    private var viewModel = MainScreenViewModel()
    private let factory: CellsFactory = MainScreenCellsFactory()
}


extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.usersList.value.itemsCount(forSection: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
        return cell
    }
}

extension MainScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
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
