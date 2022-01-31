//
//  TagBuilder.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 25/01/22.
//

import Foundation

class TagBuilder {
    private var buildEmptyTag: (() -> Tag?)?
    
    init(buildEmptyTag: (() -> Tag?)? = nil) {
        self.buildEmptyTag = buildEmptyTag
    }
    
    @discardableResult
    func buildNewTags(for notes: [Note], existingTags: [Tag]) -> [Tag] {
        let exisingTagContent = existingTags.compactMap(\.name)
        let newTags = buildTagsForNotes(notes, existingTagsContent: exisingTagContent)
        return newTags
    }
    
    private func buildTagsForNotes(_ notes: [Note], existingTagsContent: [String]) -> [Tag] {
        let tagContent = notes
            .compactMap(\.content)
            .map(findTagContent)
            .flatMap { $0 }
            .filter{ !existingTagsContent.contains($0) }
        
        let tagSet = Set<String>(tagContent)
        
        let tags = tagSet.compactMap { content -> Tag? in
            
            guard let buildEmptyTag = buildEmptyTag, let tag = buildEmptyTag() else {
                return nil
            }
            
            tag.name = content
            let notesWithTag = notes.filter { filterNoteWithTag($0, tagContent: content) }
            tag.addToNotes(NSSet(array: notesWithTag))
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
    
    private func filterNoteWithTag(_ note: Note, tagContent: String) -> Bool {
        if findTagContent(for: note.content ?? "").contains(tagContent) {
            return true
        } else {
            return false
        }
    }
    
    @discardableResult
    func updateExistingTags(_ existingTags: [Tag], with notes: [Note]) -> [Tag] {
        let updatedTags = existingTags.compactMap {
            updateExistingTag($0, with: notes)
        }
        
        return updatedTags
    }
    

    
    private func updateExistingTag(_ tag: Tag, with notes: [Note]) -> Tag? {
        guard let currentNotes = tag.notes?.allObjects as? [Note], let tagContent = tag.name else {
            return nil
        }
        
        let newNotes = notes.filter { !currentNotes.contains($0) && findTagContent(for: $0.content ?? "").contains(tagContent) }
        
        if newNotes.isEmpty {
            return nil
        }
        
        tag.addToNotes(NSSet(array: newNotes))
        return tag
    }
}
