//
//  NoteSmallCellCollectionViewCellDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 12/01/22.
//

import Foundation

protocol NoteSmallCellCollectionViewCellDelegate: AnyObject {
    func didTapDelete(for noteViewModel: NoteCellViewModel)
    func didTapShare(for noteViewModel: NoteCellViewModel)
    func didTapEdit(for noteViewModel: NoteCellViewModel)
}
