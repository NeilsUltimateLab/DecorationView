//
//  ViewController.swift
//  RoadMap
//
//  Created by Neil Jain on 8/3/19.
//  Copyright © 2019 Ratnesh Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: [UIImage] = Array(repeating: #imageLiteral(resourceName: "image1"), count: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentInset.left = 10
        self.collectionView.contentInset.right = 10
        self.collectionView.contentInset.bottom = 20
        
        self.collectionView.register(UINib(nibName: "ImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionCell")
        
        if let roadMapLayout = self.collectionView.collectionViewLayout as? RoadMapLayout {
            roadMapLayout.onTapAction = {
                print("Hurray we got the tap action from DecorationView")
            }
        }
    }
}


extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected indexPath: \(indexPath)")
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as! ImageCollectionCell
        cell.configure(with: dataSource[indexPath.item])
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.frame.width
        width -= (collectionView.contentInset.left + collectionView.contentInset.right)
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            width -= (flowLayout.sectionInset.left + flowLayout.sectionInset.right)
        }
        return CGSize(width: width, height: 200)
    }
}
