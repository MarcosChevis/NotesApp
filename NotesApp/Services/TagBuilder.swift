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
            let existingTagContent = existingTags.compactMap(\.name)
            let newTags = buildTagsForNotes(notes, existingTagsContent: existingTagContent)
            return newTags
        } catch {
            return []
        }
    }
    
    private func fetchExistingTags() throws -> [Tag] {
        do {
            let tagsRequest = Tag.fetchRequest()
            let tags = try coreDataStack.mainContext.fetch(tagsRequest)
            return tags
        } catch {
            throw TagBuilderError.failedFetchingExistingNotes
        }
    }
    
    private func buildTagsForNotes(_ notes: [NoteProtocol], existingTagsContent: [String]) -> [Tag] {
        let tagContent = notes
            .compactMap(\.content)
            .map(findTagContent)
            .flatMap { $0 }
            .filter{ existingTagsContent.contains($0) }
        let tagSet = Set<String>(tagContent)
        
        let tags = tagSet.map { content -> Tag in
            let tag = Tag(context: coreDataStack.mainContext)
            tag.name = content
            return tag
        }
        
        return tags
    }
    
    private func findTagContent(for content: String) -> [String] {
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
