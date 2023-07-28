//
//  ErrorHandler.swift
//  ViperSwiftPlaceHolder
//
//  Created by vb10 on 28.07.2023.
//

import Foundation
import UIKit

protocol UINetworkInput: UIViewController {
    func presentAlert(controller: UIAlertController)
}

final class NetworkErrorHandler {
    let viewInput: UINetworkInput

    init(viewInput: UINetworkInput) {
        self.viewInput = viewInput
    }

    func handleError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))

        if case CustomError.networkError = error {
            viewInput.presentAlert(controller: alert)
        }
    }
}
