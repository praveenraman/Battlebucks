//
//  DataManager.swift
//  AssignmentTest
//
//  Created by Praveen Kumar on 03/05/24.
//

import Foundation

struct DataManager {
    
    func getPhotoResponse(completionHandle: @escaping(Result<[PhotosData], DemoError>) -> Void){
        guard let url = URL(string: Urls.photosUrl()) else {
            return completionHandle(.failure(.BadUrl))
        }
        NetworkManager().getApiData(url: url, type: [PhotosData].self, completion: completionHandle)
    }
}
