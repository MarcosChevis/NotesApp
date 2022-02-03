//
//  ThemeCollectionViewCellDelegate.swift
//  NotesApp
//
//  Created by Marcos Chevis on 02/02/22.
//

import Foundation

protocol ThemeCollectionViewCellDelegate: AnyObject {
    func didTapEdit(with id: String)
    func didTapDelete(with id: String)
}
