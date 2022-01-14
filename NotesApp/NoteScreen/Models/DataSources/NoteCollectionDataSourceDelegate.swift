//
//  NoteCollectionDataSourceDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 13/01/22.
//

import Foundation

protocol NoteCollectionDataSourceDelegate: AnyObject {
    func updateItem(_ viewModel: NoteCellViewModel, at indexPath: IndexPath)
    func insertItem(_ viewModel: NoteCellViewModel, at indexPath: IndexPath)
    func deleteItem(at indexPath: IndexPath)
    func moveItem(to indexPath: IndexPath)
}
