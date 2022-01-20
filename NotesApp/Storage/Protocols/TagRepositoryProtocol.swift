//
//  TagRepositoryProtocol.swift
//  NotesApp
//
//  Created by Rebecca Mello on 18/01/22.
//

import Foundation


protocol TagRepositoryProtocol: AnyObject {
    var delegate: TagRepositoryDelegate? { get set }
    func getAllTags() throws -> [TagCellViewModel]
}

protocol TagRepositoryDelegate: AnyObject {
    func insertTag(_ tag: TagCellViewModel)
    func deleteTag(_ tag: TagCellViewModel)
}
