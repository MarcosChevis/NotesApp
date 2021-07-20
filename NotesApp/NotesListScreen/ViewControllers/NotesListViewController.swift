//
//  NotesListViewController.swift
//  NotesApp
//
//  Created by Marcos Chevis on 13/07/21.
//

import Foundation
import UIKit

class NotesListTableViewController: UITableViewController {
    
    var mockData: [NoteData] = Singleton.shared.data
    var identifier: String = "identifier"
    
    weak var delegate: NoteListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    
    // MARK: DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = mockData[indexPath.row].content
        return cell
    }

    // MARK: Delegate
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.updateText(text: mockData[indexPath.row].content)
        navigationController?.popViewController(animated: true)
    }
    
}

