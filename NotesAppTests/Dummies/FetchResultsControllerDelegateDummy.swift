//
//  FetchResultsControllerDelegateDummy.swift
//  NotesAppTests
//
//  Created by Gabriel Ferreira de Carvalho on 13/01/22.
//

import Foundation
import CoreData

class FetchResultsControllerDelegateDummy<ResultType : NSFetchRequestResult>: NSObject, NSFetchedResultsControllerDelegate {
 
    var data: [ResultType] = []
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let object = anObject as? ResultType {
                data.append(object)
            }
        case .delete:
            if let indexPath = indexPath {
                data.remove(at: indexPath.row)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                data.move(fromOffsets: IndexSet(integer: indexPath.row), toOffset: newIndexPath.row-indexPath.row)
            }
        case .update:
            if let object = anObject as? ResultType, let indexPath = indexPath {
                data[indexPath.row] = object
            }
        @unknown default:
            break
        }
    }
}
