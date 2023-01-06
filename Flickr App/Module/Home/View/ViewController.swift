//
//  ViewController.swift
//  Flickr App
//
//  Created by Raj Kumar on 05/01/23.
//

import UIKit
import EasyTipView

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = FlickrViewModel(flickrService: FlickrService())
    var selectedCell = -1

    var toolTipView:EasyTipView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    func setUp() {
        viewModel.fetchFlickrImages()
        viewModel.didFinishFetch = {
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func refreshTapped(_ sender: UIBarButtonItem) {
        setUp()
    }

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.flickModelData?.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlickrCollectionCell", for: indexPath) as? FlickrCollectionCell {
            let contentData = viewModel.flickModelData?.items?[indexPath.row]
            if let imageStr = contentData?.media?.m {
                cell.flickImageView.sd_setImage(with: URL(string: imageStr), completed: nil)
            }
            cell.flickImageView.borderColor = selectedCell == indexPath.row ? .blue : .lightGray
            return cell
        }
        return UICollectionViewCell.init()
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height / 2.8)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contentData = viewModel.flickModelData?.items?[indexPath.row]
        let title = contentData?.title ?? ""
        let description = contentData?.itemDescription ?? ""
        
        if selectedCell == indexPath.row {
            toolTipView?.dismiss()
            self.selectedCell = -1
            collectionView.reloadData()
            return
        }
        
        self.selectedCell = indexPath.row
        collectionView.reloadData()
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlickrCollectionCell", for: indexPath) as? FlickrCollectionCell {
            var preferences = EasyTipView.Preferences()
            preferences.drawing.font = UIFont(name: "HelveticaNeue-Medium", size: 16)!
            preferences.drawing.backgroundColor = UIColor.blue
            preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
            toolTipView?.dismiss()
            toolTipView = EasyTipView(text: title + "\n" + description.html2String.trimmingCharacters(in: .whitespaces), preferences: preferences)
            toolTipView?.show(forView: cell, withinSuperview: collectionView)
        }
    }
}
