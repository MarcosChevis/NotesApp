//
//  NoteCollectionViewCellDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 01/02/22.
//

import Foundation

protocol NoteCollectionViewCellDelegate: AnyObject {
    func deleteNote(_ viewModel: NoteCellViewModel)
    func shareNote(_ viewModel: NoteCellViewModel)
}
