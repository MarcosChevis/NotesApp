//
//  TagBuilder.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 25/01/22.
//

import Foundation

protocol TagBuilderProtocol {
    func build(for notes: [NoteProtocol]) -> [TagProtocol]
}

struct TagBuilder: TagBuilderProtocol {
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func build(for notes: [NoteProtocol]) -> [TagProtocol] {
        do {
            let existingTags = try fetchExistingTags()
            return []
        } catch {
            return []
        }
    }
    
    private func fetchExistingTags() throws -> [TagProtocol] {
        do {
            let tagsRequest = Tag.fetchRequest()
            let tags = try coreDataStack.mainContext.fetch(tagsRequest)
            return tags
        } catch {
            throw TagBuilderError.failedFetchingExistingNotes
        }
    }
    
    private func buildTagsForNotes(_ notes: [NoteProtocol]) -> [TagProtocol] {
        let tagContent = notes
            .compactMap(\.content)
            .map(findTagContent)
            .flatMap { $0 }
        
        return []
    }
    
    func findTagContent(for content: String) -> [String] {
        let separetedContent = content
            .split(separator: " ")
            .map(String.init)
        
        let tags = separetedContent
            .filter { $0.starts(with: "#") }
        return tags
    }
    
    enum TagBuilderError: Error {
        case failedFetchingExistingNotes
    }
}
