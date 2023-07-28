//
//  HomePresenter.swift
//  ViperSwiftPlaceHolder
//
//  Created by vb10 on 15.07.2023.
//

import Foundation



final class HomePresenter: HomeViewPresenterInput {
    let interactor: HomeInteractor
    let view: HomeViewInputs

    let networkErrorHandler: NetworkErrorHandler

    init(interactor: HomeInteractor, view: HomeViewInputs, networkInput: UINetworkInput) {
        self.interactor = interactor
        self.view = view
        self.networkErrorHandler = NetworkErrorHandler(viewInput: networkInput)
    }

    private func fetchCats() {
        interactor.fetchCats(url: "\(ProductConstants.BASE_URL)/\(ServicePath.http.rawValue)") { response in
            switch response {
            case .success(let items):
                self.view.reloadTableView(cats: items)
            case .failure:
                print("")
            }

            self.view.indicatorView(animate: false)
        }
    }

    private func fetchCatsAsync() async {
        let response = await interactor.fetchCatsAsync()

        switch response {
        case .success(let items):
            view.reloadTableView(cats: items ?? [])
        case .failure(let error):
            networkErrorHandler.handleError(error: error)
        }
    }

    func onTapCell(model: CatEntity) {
        print(model)
    }

    func viewDidLoad() {
        view.indicatorView(animate: true)
        Task {
            @MainActor in
            await fetchCatsAsync()
        }
    }
}
