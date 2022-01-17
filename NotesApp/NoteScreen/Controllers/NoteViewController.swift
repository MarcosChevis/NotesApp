//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Marcos Chevis on 12/01/22.
//

import Foundation
import UIKit

class NoteViewController: UIViewController {
    
    var palette: ColorSet
    var contentView: NoteView
    var collectionDataSource: UICollectionViewDataSource
    
    
    init(palette: ColorSet, collectionDataSource: UICollectionViewDataSource) {
        self.contentView = NoteView(palette: palette)
        self.palette = palette
        self.collectionDataSource = collectionDataSource
        
        super.init(nibName: nil, bundle: nil)
        
        self.contentView.collectionView.dataSource = collectionDataSource
        self.contentView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupNavigationBar()
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        setupToolbar()
        
    }
    
    func setupToolbar() {
        self.navigationController?.isToolbarHidden = false
        self.toolbarItems = contentView.toolbarItems
    }
    
    
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    func setupNavigationBar() {
        title = "abrobinha"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: palette.palette().text]
        navigationItem.rightBarButtonItem = contentView.shareButton
        
    }
}

extension NoteViewController: NoteViewDelegate {
    func didDelete() {
        print("coisas de delete")
        
    }
    
    func didAllNotes() {
        print("coisas de all notes")
        
    }
    
    func didAdd() {
        print("coisas de add")
        
    }
    
    func didShare() {
        print("coisas de share")
        
        let note = "ooooi"
        
        // set up activity view controller
        let noteToShare = note
        let activityViewController = UIActivityViewController(activityItems: [noteToShare], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}
