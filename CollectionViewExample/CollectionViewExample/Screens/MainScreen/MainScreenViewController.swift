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
    @IBOutlet weak var controlPanelView: ControlPanelView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionFlow = viewModel.controlPanelModel.makeCollectionFlow()
        collectionView?.collectionViewLayout = collectionFlow
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
        viewModel.controlPanelModel.itemHeight.didChange = { [weak self] value in
            guard let strongSelf = self else {
                return
            }
            strongSelf.collectionFlow.itemSize = CGSize(width: strongSelf.viewModel.controlPanelModel.itemWidth.value,
                                                        height: value)
            strongSelf.collectionView?.collectionViewLayout = strongSelf.collectionFlow
        }
        viewModel.controlPanelModel.itemWidth.didChange = { [weak self] value in
            guard let strongSelf = self else {
                return
            }
            strongSelf.collectionFlow.itemSize = CGSize(width: value,
                                                        height: strongSelf.viewModel.controlPanelModel.itemHeight.value)
            strongSelf.collectionView?.collectionViewLayout = strongSelf.collectionFlow
        }
        viewModel.controlPanelModel.scrollDirection.didChange = { [weak self] value in
            guard let strongSelf = self else {
                return
            }
            strongSelf.collectionFlow.scrollDirection = value.collectionViewScrollDirection
            strongSelf.collectionView?.collectionViewLayout = strongSelf.collectionFlow
        }
        controlPanelView?.viewModel = viewModel.controlPanelModel
    }
    
    private var collectionFlow = UICollectionViewFlowLayout()
    private var viewModel = MainScreenViewModel()
    private let factory: CellsFactory = MainScreenCellsFactory()
}

extension ControlPanelViewModelOutput {
    func makeCollectionFlow() -> UICollectionViewFlowLayout {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: itemWidth.value, height: itemHeight.value)
        flow.scrollDirection = scrollDirection.value.collectionViewScrollDirection
        return flow
    }
}

extension ControlPanelViewModel.ScrollDirection {
    var collectionViewScrollDirection: UICollectionView.ScrollDirection {
        switch self {
        case .vertical:
            return .vertical
        case .horizontal:
            return .horizontal
        }
    }
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
