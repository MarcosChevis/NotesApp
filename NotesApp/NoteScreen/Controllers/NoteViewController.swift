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
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    func setupNavigationBar() {
        title = "abrobinha"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = contentView.shareButton

    }
}

extension NoteViewController: NoteViewDelegate {
    func didShare() {
        print("coisas de share")
    }
}
