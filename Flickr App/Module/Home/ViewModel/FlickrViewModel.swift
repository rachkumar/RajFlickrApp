//
//  FlickrViewModel.swift
//  Flickr App
//
//  Created by Raj Kumar on 06/01/23.
//

import Foundation

class FlickrViewModel {
    
    var flickModelData: FlickrModel? {
        didSet {
            guard flickModelData != nil else { return }
            self.didFinishFetch?()
        }
    }
    
    var didFinishFetch: (() -> ())?
    
    private var dataService: FlickrService?
    
    init(flickrService: FlickrService) {
        self.dataService = flickrService
    }
    
    // MARK: - Network call
    func fetchFlickrImages() {
        self.dataService?.requestFetchPhoto(completion: { flickrModel, err in
            if let error = err {
                print("error occured", error)
                return
            }
            self.flickModelData = flickrModel
        })
    }
    
    
}
