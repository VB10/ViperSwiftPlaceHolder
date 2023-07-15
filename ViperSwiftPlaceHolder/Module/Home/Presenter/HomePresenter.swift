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

    init(interactor: HomeInteractor, view: HomeViewInputs) {
        self.interactor = interactor
        self.view = view
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

    func onTapCell(model: CatEntity) {
        print(model)
    }

    func viewDidLoad() {
        view.indicatorView(animate: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.fetchCats()
        }
    }
}
