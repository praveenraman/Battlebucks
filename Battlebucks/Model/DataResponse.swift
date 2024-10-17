//
//  DataResponse.swift
//  AssignmentTest
//
//  Created by Praveen Kumar on 03/05/24.
//

import Foundation

struct DataResponse: Decodable {
    var photo: [PhotosData]
}

struct PhotosData: Decodable{
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
}
