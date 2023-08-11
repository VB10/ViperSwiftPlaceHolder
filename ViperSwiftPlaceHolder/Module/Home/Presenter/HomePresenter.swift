//
//  HomePresenter.swift
//  ViperSwiftPlaceHolder
//
//  Created by vb10 on 15.07.2023.
//

import Foundation

final class HomePresenter: HomeViewPresenterInput {
    private let interactor: HomeInteractor
    private let viewInputs: HomeViewInputs
    private let networkErrorHandler: NetworkErrorHandler
    private let viewEntitity: HomeViewEntity
    private let router: HomeRouterOutput

    init(interactor: HomeInteractor, viewInputs: HomeViewInputs,
         viewable: Viewable,
         networkInput: UINetworkInput, viewEntitity: HomeViewEntity)
    {
        self.viewEntitity = viewEntitity
        self.interactor = interactor
        self.viewInputs = viewInputs
        self.networkErrorHandler = NetworkErrorHandler(viewInput: networkInput)
        self.router = HomeRouterOutput(viewController: viewable)
    }

    private func fetchCats() {
        interactor.fetchCats(url: "\(ProductConstants.BASE_URL)/\(ServicePath.http.rawValue)") { response in
            switch response {
            case .success(let items):
                self.viewInputs.reloadTableView(cats: items)
            case .failure:
                print("")
            }

            self.viewInputs.indicatorView(animate: false)
        }
    }

    private func fetchCatsAsync() async {
        let response = await interactor.fetchCatsAsync()

        switch response {
        case .success(let items):
            viewInputs.reloadTableView(cats: items ?? [])
        case .failure(let error):
            networkErrorHandler.handleError(error: error)
        }
    }

    func onTapCell(model: CatEntity) {
        router.navigateToDetail(cat: model)
    }

    func viewDidLoad() {
        viewInputs.indicatorView(animate: true)
        viewInputs.updateTitle(value: viewEntitity.title)
        viewInputs.setupTableViewCell()
        Task {
            @MainActor in
            await fetchCatsAsync()
        }
    }
}
