//
//  TagDelegateDummy.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 02/02/22.
//

import Foundation
@testable import NotesApp

class TagRepositoryDelegateDummy: TagRepositoryDelegate {
    var data: [TagCellViewModel] = []
    
    func insertTag(_ tag: TagCellViewModel) {
        data.append(tag)
    }
    
    func deleteTag(_ tag: TagCellViewModel) {
        data.removeAll { $0 == tag }
    }
}
