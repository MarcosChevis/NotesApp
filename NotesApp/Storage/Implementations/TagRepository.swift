//
//  TagRepository.swift
//  NotesApp
//
//  Created by Rebecca Mello on 18/01/22.
//

import Foundation
import CoreData

class TagRepository: NSObject, TagRepositoryProtocol {
    weak var delegate: TagRepositoryDelegate?
    private var fetchResultsController: NSFetchedResultsController<Tag>
    private var coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
        let request = Tag.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Tag.name, ascending: true)]
        fetchResultsController = NSFetchedResultsController<Tag>(fetchRequest: request, managedObjectContext: coreDataStack.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
    }
    
    func getAllTags() throws -> [TagCellViewModel] {
        try fetchResultsController.performFetch()
        
        guard let tags = fetchResultsController.fetchedObjects else {
            throw RepositoryError.errorFetchingObjects
        }
        
        let viewModels = tags.map({
            TagCellViewModel(tag: $0)
        })
        
        return viewModels
    }
}

extension TagRepository: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let tag = anObject as? Tag else { return }
        
        switch type {
        case .insert:
            insertTag(tag)
        case .delete:
            deleteTag(tag)
        case .move:
            break
        case .update:
            break
        @unknown default:
            break
        }
    }
    
    func insertTag(_ tag: Tag) {
        let viewModel = TagCellViewModel(tag: tag)
        delegate?.insertTag(viewModel)
    }
    
    func deleteTag(_ tag: Tag) {
        let viewModel = TagCellViewModel(tag: tag)
        delegate?.deleteTag(viewModel)
    }
}
