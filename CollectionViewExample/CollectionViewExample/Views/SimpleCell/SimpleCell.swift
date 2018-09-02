//
//  SimpleCell.swift
//  CollectionViewExample
//
//  Created by Eldar Pikunov on 01/09/2018.
//  Copyright © 2018 EPik-dev. All rights reserved.
//

import UIKit

protocol ConfigurableCell: AnyObject {
    var viewModel: CellViewModel? { get set }
}

class SimpleCell: UICollectionViewCell, ConfigurableCell {
    var viewModel: CellViewModel? {
        get {
            return concreteViewModel
        }
        
        set {
            concreteViewModel = newValue as? SimpleCellViewModel
            updateControls(viewModel: concreteViewModel)
        }
    }
    
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var imageView: UIImageView?
    
    private var concreteViewModel: SimpleCellViewModel?
    private func updateControls(viewModel: SimpleCellViewModel?) {
        titleLabel?.text = viewModel?.userName ?? ""
        imageView?.image = UIImage(named: viewModel?.avatarName ?? "")
        
    }
}
