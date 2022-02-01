//
//  NoteCollectionViewCellDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 01/02/22.
//

import Foundation

protocol NoteCollectionViewCellDelegate: AnyObject {
    func didTapDeleteNote(_ viewModel: NoteCellViewModel)
    func didTapShareNote(_ viewModel: NoteCellViewModel)
}
