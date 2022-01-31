//
//  CustomThemeBuilderCoordinatorDummy.swift
//  NotesAppTests
//
//  Created by Marcos Chevis on 31/01/22.
//

import Foundation
import UIKit
@testable import NotesApp

class CustomThemeBuilderCoordinatorDummy: CustomThemeBuilderCoordinatorProtocol {
    
    var didDismiss = false
    var didPresentSingleAlertAction = false
    var didPresentErrorAlert = false
    var selectColor: UIColor = .clear
    
    
    func dismiss() {
        didDismiss = true
    }
    
    func showColorPicker(delegate: UIColorPickerViewControllerDelegate) {
        let colorPickerViewController = UIColorPickerViewController()
        colorPickerViewController.selectedColor = selectColor
        delegate.colorPickerViewControllerDidFinish?(colorPickerViewController)
    }
    
    func presentSingleActionAlert(for alertCase: UIAlertController.CommonAlert, _ action: @escaping () -> Void) {
        didPresentSingleAlertAction = true
        action()
    }
    
    func presentErrorAlert(with message: String) {
        didPresentErrorAlert = true
    }
    
    
}
