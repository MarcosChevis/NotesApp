//
//  NotesListViewController.swift
//  NotesApp
//
//  Created by Marcos Chevis on 13/07/21.
//

import Foundation
import UIKit
import CoreData

class NotesListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    //var mockData: [NoteData] = Singleton.shared.data
    private let coreData = CoreDataStack.shared
    
    private lazy var frcNote: NSFetchedResultsController<Note> = {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Note.creationDate, ascending: false)]
        
        let frc = NSFetchedResultsController<Note>(fetchRequest: fetchRequest,
                                                   managedObjectContext: coreData.mainContext,
                                                   sectionNameKeyPath: nil,
                                                   cacheName: nil)
        return frc
    }()
    
//    private lazy var frcTag: NSFetchedResultsController<Tag> = {
//
//    }()
    
    var identifier: String = "identifier"
    
    lazy var searchController: UISearchController = {
        let s = UISearchController(searchResultsController: nil)
        s.searchResultsUpdater = self
        s.obscuresBackgroundDuringPresentation = false
        s.searchBar.placeholder = "Search in Notes"
        s.searchBar.sizeToFit()
        s.searchBar.searchBarStyle = .prominent
        
        s.searchBar.scopeButtonTitles = []
        s.searchBar.delegate = self
        
        return s
    }()
    
    weak var delegate: NoteListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try frcNote.performFetch()
        } catch {
            print("Não foi")
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
//    func filteredForSearchBar(searchText: String, scope: String = "All") {
//        filteredNotes = mockData.filter({ (note: NoteData) -> Bool in
//            return true
//        })
//    }
    
    
    // MARK: DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frcNote.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let object = frcNote.object(at: indexPath)
        cell.textLabel?.text = object.content
        return cell
    }

    // MARK: TableViewDelegate
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = frcNote.object(at: indexPath)
        delegate?.updateText(coreDataObject: content)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}

//MARK: SearchBarDelegate
extension NotesListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
}

//MARK: SearchResultUpdating
extension NotesListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
