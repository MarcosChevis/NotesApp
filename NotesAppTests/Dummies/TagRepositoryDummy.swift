//
//  TagRepositoryDummy.swift
//  NotesAppTests
//
//  Created by Rebecca Mello on 19/01/22.
//

import Foundation
@testable import NotesApp

class TagRepositoryDummy: TagRepositoryProtocol {
    weak var delegate: TagRepositoryDelegate?
    var mock: [TagCellViewModel] = []
    
    func getAllTags() throws -> [TagCellViewModel] {
        mock
    }
}
