//
//  ControlPanelView.swift
//  CollectionViewExample
//
//  Created by Eldar Pikunov on 02/09/2018.
//  Copyright © 2018 EPik-dev. All rights reserved.
//

import UIKit

class ControlPanelView: UIView {
    @IBOutlet weak var itemWidthTextField: UITextField?
    @IBOutlet weak var itemHeightTextField: UITextField?
    @IBOutlet weak var scrollOrientationControl: UISegmentedControl?
    
    @IBAction func segmentChanged(sender: AnyObject) {
        let index = scrollOrientationControl?.selectedSegmentIndex ?? 0
        _viewModel?._scrollOrientation.value = ControlPanelViewModel.ScrollDirection(rawValue: index) ?? .vertical
    }
    
    var viewModel: ControlPanelViewModelOutput? {
        get {
            return _viewModel
        }
        set {
            _viewModel = newValue as? ControlPanelViewModel
            updateControls()
        }
    }
    
    private func updateControls() {
        guard let viewModel = viewModel else {
            return
        }
        itemWidthTextField?.text = String(viewModel.itemWidth.value)
        itemHeightTextField?.text = String(viewModel.itemHeight.value)
        scrollOrientationControl?.selectedSegmentIndex = viewModel.scrollDirection.value.rawValue
    }

    private var _viewModel: ControlPanelViewModel?
}

extension ControlPanelView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == itemWidthTextField {
            if let text = textField.text, let value = Int(text) {
                _viewModel?._itemWidth.value = value
            }
            else {
                _viewModel?._itemWidth.value = 0
            }
        }
        if textField == itemHeightTextField {
            if let text = textField.text, let value = Int(text) {
                _viewModel?._itemHeight.value = value
            }
            else {
                _viewModel?._itemHeight.value = 0
            }
        }
    }
}
