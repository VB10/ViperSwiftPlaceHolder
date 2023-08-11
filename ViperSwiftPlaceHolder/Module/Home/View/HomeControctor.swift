//
//  HomeControctor.swift
//  ViperSwiftPlaceHolder
//
//  Created by vb10 on 15.07.2023.
//

import Foundation

protocol HomeInteractorOutputs {
    func onSuccessSearch()
    func onErrorSearch()
}

protocol HomeViewInputs {
    func configure()
    func reloadTableView(cats: [CatEntity])
    func setupTableViewCell()
    func indicatorView(animate: Bool)
    func sortByTitle()
    func updateTitle(value: String)
}

protocol HomeViewPresenterInput {
    func viewDidLoad()
    func onTapCell(model: CatEntity)
}
