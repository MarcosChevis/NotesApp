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
    var dataSource: NoteCollectionDataSource
    
    
    init(palette: ColorSet, collectionDataSource: NoteCollectionDataSource) {
        self.contentView = NoteView(palette: palette)
        self.palette = palette
        self.dataSource = collectionDataSource
        
        super.init(nibName: nil, bundle: nil)
        
        self.contentView.collectionView.dataSource = collectionDataSource
        self.dataSource.delegate = self
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
        
        do {
            try dataSource.setupFetching()
        } catch {
        }
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
        do {
            try dataSource.addItem(.init(id: nil, title: "Titulo", content: "Counteudo com coisas"))
        } catch {
            
        }
        
    }
    
    func didShare() {
        print("coisas de share")
    }
}

extension NoteViewController: NoteCollectionDataSourceDelegate {
    func updateItem(_ viewModel: NoteCellViewModel, at indexPath: IndexPath) {
        guard let cell = contentView.collectionView.cellForItem(at: indexPath) as? NoteCollectionViewCell else {
            return
        }
        
        cell.setup(colorPalette: ColorSet.classic.palette(), title: viewModel.title, content: viewModel.content)
    }
    
    func insertItem(_ viewModel: NoteCellViewModel, at indexPath: IndexPath) {
        print(indexPath)
        contentView.collectionView.insertItems(at: [indexPath])
        contentView.collectionView.reloadData()
        contentView.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    func deleteItem(at indexPath: IndexPath) {
        contentView.collectionView.deleteItems(at: [indexPath])
    }
    
    func moveItem(to indexPath: IndexPath) {
        
    }
}

extension NoteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        print("\(indexPath)")
    }
}
