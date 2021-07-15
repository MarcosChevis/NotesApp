//
//  NotesListTableView.swift
//  NotesApp
//
//  Created by Marcos Chevis on 13/07/21.
//

import Foundation
import UIKit


class NotesListTableView: UITableView {
    
    var data: [Int] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - DataSource
extension NotesListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NoteCellView = NoteCellView(frame: .zero)
        return cell
    }

}
//MARK: - Delegate
extension NotesListTableView: UITableViewDelegate {
    
}
