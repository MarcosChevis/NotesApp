//
//  NoteSmallCellCollectionViewCellDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 12/01/22.
//

import Foundation

protocol NoteSmallCellCollectionViewCellDelegate: AnyObject {
    func didTapDelete(for noteViewModel: SmallNoteCellViewModel)
    func didTapShare(for noteViewModel: SmallNoteCellViewModel)
    func didTapEdit(for noteViewModel: SmallNoteCellViewModel)
}
