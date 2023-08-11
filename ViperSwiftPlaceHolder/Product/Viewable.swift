//
//  Viewable.swift
//  ViperSwiftPlaceHolder
//
//  Created by vb10 on 11.08.2023.
//

import Foundation
import UIKit

// push,pop

protocol Viewable {
    func present(_ viewController: UIViewController)
    func dismiss()
}

extension Viewable where Self: UIViewController {
    func present(_ viewController: UIViewController) {
        self.present(viewController, animated: true)
    }

    func dismiss() {
        self.dismiss()
    }
}
