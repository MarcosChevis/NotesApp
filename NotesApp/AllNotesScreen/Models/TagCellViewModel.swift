//
//  TagViewModel.swift
//  NotesApp
//
//  Created by Rebecca Mello on 18/01/22.
//

import Foundation

class TagCellViewModel {
    var tag: TagProtocol
    
    init(tag: TagProtocol) {
        self.tag = tag
    }
}

extension TagCellViewModel: Hashable {
    // se tem o mesmo ID eh o mesmo objeto
    static func == (lhs: TagCellViewModel, rhs: TagCellViewModel) -> Bool {
        lhs.tag.tagID == rhs.tag.tagID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(tag.tagID)
        hasher.combine(tag.name)
    }
}
