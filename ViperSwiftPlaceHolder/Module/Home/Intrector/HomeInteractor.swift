//
//  HomeInteractor.swift
//  ViperSwiftPlaceHolder
//
//  Created by vb10 on 15.07.2023.
//

import Alamofire
import Foundation

class HomeInteractor {
//    Async await
//
    func fetchCats(url: String, onResponse: @escaping (Result<[CatEntity], Error>) -> Void) {
        AF.request(url,
                   method: .get).validate().responseDecodable(of: [CatEntity].self) { response in
            guard let model = response.value else {
                guard let error = response.error else {
//                    TODO: Exception
                    return
                }
                onResponse(.failure(error))
                return
            }
            onResponse(.success(model))
        }
    }
}

enum ServicePath: String {
    case http = "http.json"
}
