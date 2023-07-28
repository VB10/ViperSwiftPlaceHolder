//
//  HomeInteractor.swift
//  ViperSwiftPlaceHolder
//
//  Created by vb10 on 15.07.2023.
//

import Alamofire
import Foundation

final class HomeInteractor {
    let networkManager: INetworkManager

    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }

    func fetchCats(url: String, onResponse: @escaping (Result<[CatEntity], Error>) -> Void) {
        AF.request(url,
                   method: .get).validate().responseDecodable(of: [CatEntity].self) { response in
            guard let model = response.value else {
                guard let error = response.error else {
//                 TODO: Exception
                    return
                }
                onResponse(.failure(error))
                return
            }
            onResponse(.success(model))
        }
    }

    func fetchCatsAsync() async -> Result<[CatEntity]?, Error> {
        let response = await networkManager.fetch(url: .dummy, method: .get, type: [CatEntity].self)
        return response
    }
}

enum ServicePath: String {
    case http = "http.json"
}
