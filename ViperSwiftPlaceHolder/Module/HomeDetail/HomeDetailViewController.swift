//
//  HomeDetailViewController.swift
//  ViperSwiftPlaceHolder
//
//  Created by vb10 on 11.08.2023.
//

import UIKit

final class HomeDetailViewController: UIViewController {
    var homeDetailEntity: HomeDetailEntity?

    lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = homeDetailEntity?.cat?.description ?? ""
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(labelTitle)
        makeViewOperation()
    }

    private func makeViewOperation() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
        }
        labelTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
