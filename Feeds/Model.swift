//
//  FeedModel.swift
//  Feed
//
//  Created by Sarathi M on 9/14/21.
//

import Foundation

// MARK: - Feed
struct Feed: Codable {
    var kind: String?
    var data: FeedData?
}

// MARK: - FeedData
struct FeedData: Codable {
    var after: String?
    var children: [Child]?
    let before: String?
}

// MARK: - Child
struct Child: Codable {
    let kind: String?
    let data: ChildData?
}

// MARK: - ChildData
struct ChildData: Codable {
    let title: String?
    let thumbnailHeight: Int?
    let thumbnailWidth: Int?
    let score: Int?
    let thumbnail: String?
    let numComments: Int?

    enum CodingKeys: String, CodingKey {
        case thumbnailHeight = "thumbnail_height"
        case thumbnailWidth = "thumbnail_width"
        case title
        case score
        case thumbnail
        case numComments = "num_comments"
    }
}
