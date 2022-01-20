//
//  AllNotesViewController+TagRepositoryDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension AllNotesViewController: TagRepositoryDelegate {
    func insertTag(_ tag: TagCellViewModel) {
        insertItem(.tag(tagViewModel: tag), at: .tags)
    }
    
    func deleteTag(_ tag: TagCellViewModel) {
        deleteItem(.tag(tagViewModel: tag), at: .tags)
    }
}
