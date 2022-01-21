//
//  ThemesViewController+UICollectionViewDelegate.swift
//  NotesApp
//
//  Created by Gabriel Ferreira de Carvalho on 20/01/22.
//

import UIKit

extension ThemesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in 0..<collectionDataSource.data.count {
            collectionDataSource.data[index].isSelected = index == indexPath.row
            if collectionDataSource.data[index].isSelected {
                
                settings.theme = collectionDataSource.data[index].colorSet
                settings.changeTheme(palette: collectionDataSource.data[index].colorSet)
            }
        }
        collectionView.reloadData()
        
    }
    
}
