//
//  HomeRouter.swift
//  ViperSwiftPlaceHolder
//
//  Created by vb10 on 11.08.2023.
//

import Foundation

/// Input: core operation like open etc.

struct HomeRouterInput {
    private func currentViewController(viewEntity: HomeViewEntity?) -> HomeViewController {
        let homeViewController = HomeViewController()

        homeViewController.presenter = HomePresenter(
            interactor: HomeInteractor(
                networkManager: AlamofireNetworkManager.shared),
            viewInputs: homeViewController,
            viewable: homeViewController,
            networkInput: homeViewController,
            viewEntitity: viewEntity ?? HomeViewEntity(title: "vb10")
        )
        return homeViewController
    }

//    from
    func start(viewEntity: HomeViewEntity?) -> HomeViewController {
        return currentViewController(viewEntity: viewEntity)
    }
}

/// Output: external operation

struct HomeRouterOutput {
    let viewController: Viewable
    func navigateToDetail(cat: CatEntity) {
        let detailEntity = HomeDetailEntity(cat: cat)
        HomeDetailRouterInput().present(from: viewController,
                                        homeDetailEntity: detailEntity)
    }
}
