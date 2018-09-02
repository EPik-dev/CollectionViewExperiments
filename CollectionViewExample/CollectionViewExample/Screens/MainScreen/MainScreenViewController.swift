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
        guard let cellModel = viewModel.usersList.value.item(at: indexPath.item, forSection: indexPath.section) else {
            fatalError("ViewModel does not match with collection")
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellModel.reusableCellId, for: indexPath)
    }
}

extension MainScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cellModel = viewModel.usersList.value.item(at: indexPath.item, forSection: indexPath.section) else {
            fatalError("ViewModel does not match with collection")
        }
        guard let configurableCell = cell as? ConfigurableCell else {
            return
        }
        configurableCell.viewModel = cellModel
    }
}

class MainScreenCellsFactory: CellsFactory {
    func makeCell(forType type: CellType) -> ConfigurableCell&AnyObject {
        switch type {
        case .simple:
            return SimpleCell()
        }
    }
    
    func makeCellViewModel(forType type: CellType) -> CellViewModel {
        switch type {
        case .simple:
            return SimpleCellViewModel(userName: "", avatarName: "")
        }
    }
}
