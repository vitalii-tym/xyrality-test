//
//  WorldsListViewController.swift
//  Xyrality Login Test
//
//  Created by Vitaliy Tim on 2/24/17.
//  Copyright © 2017 Vitaliy Timoshenko. All rights reserved.
//

import UIKit

class aWorldCell: UICollectionViewCell {
    @IBOutlet weak var labelWorldName: UILabel!
}

class WorldsListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var worldsList: XyralityWorldsList?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return worldsList?.worlds.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "aWorld", for: indexPath) as! aWorldCell
        
        cell.labelWorldName.text = worldsList?.worlds[indexPath.row].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width, height: 25)

    }
}
