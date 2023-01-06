//
//  FlickrModel.swift
//  Flickr App
//
//  Created by Raj Kumar on 06/01/23.
//
import Foundation

// MARK: - FlickrModel
struct FlickrModel: Codable {
    let title: String?
    let link: String?
    let flickrModelDescription: String?
    let modified: String?
    let generator: String?
    let items: [Item]?

    enum CodingKeys: String, CodingKey {
        case title, link
        case flickrModelDescription = "description"
        case modified, generator, items
    }
}

// MARK: - Item
struct Item: Codable {
    let title: String?
    let link: String?
    let media: Media?
    let dateTaken: String?
    let itemDescription: String?
    let published: String?
    let author, authorID, tags: String?

    enum CodingKeys: String, CodingKey {
        case title, link, media
        case dateTaken = "date_taken"
        case itemDescription = "description"
        case published, author
        case authorID = "author_id"
        case tags
    }
}

// MARK: - Media
struct Media: Codable {
    let m: String?
}
