//
//  NotesListViewController.swift
//  NotesApp
//
//  Created by Marcos Chevis on 13/07/21.
//
import UIKit
import CoreData

class NotesListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    private let coreData = CoreDataStack.shared
    
    private lazy var frcNote: NSFetchedResultsController<Note> = {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Note.modificationDate, ascending: false)]
        
        
        let frc = NSFetchedResultsController<Note>(fetchRequest: fetchRequest,
                                                   managedObjectContext: coreData.mainContext,
                                                   sectionNameKeyPath: nil,
                                                   cacheName: nil)
        return frc
    }()
    
    var beganUpdates = false
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
        
        tableView.tableHeaderView = searchController.searchBar
        do {
            try frcNote.performFetch()
        } catch {
            print("Não foi")
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    // MARK: TableViewDataSource
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let item = frcNote.fetchedObjects?[indexPath.row] else { return }
            coreData.delete(note: item)
            do {
                try coreData.save()
                try frcNote.performFetch()
            } catch {
                print("nao foi")
            }
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = frcNote.object(at: indexPath)
        delegate?.updateText(coreDataObject: content)
        searchController.isActive = false
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
        beganUpdates = true
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
        case .delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        
        case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            self.tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            self.tableView.deleteRows(at: [indexPath!], with: .fade)
            self.tableView.insertRows(at: [newIndexPath!], with: .fade)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if beganUpdates {
            self.tableView.endUpdates()
        }
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
        let searchText = searchController.searchBar.text ?? ""
        var predicate: NSPredicate?
        if searchText.count > 0 {
            predicate = NSPredicate(format: "(content contains[cd] %@)", searchText)
        } else {
            predicate = nil
        }
        
        frcNote.fetchRequest.predicate = predicate
        
        do {
            try frcNote.performFetch()
            tableView.reloadData()
        } catch let err {
            print(err)
        }
        
    }
}
