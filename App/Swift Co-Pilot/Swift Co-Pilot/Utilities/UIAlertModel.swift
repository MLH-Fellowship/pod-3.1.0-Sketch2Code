//
//  UIAlertModel.swift
//  Swift Co-Pilot
//
//  Created by Gokul Nair on 06/08/21.
//

import UIKit

extension UIViewController {
    func errorAlert(mesg: String) {
        let alert = UIAlertController(title: "Error", message: mesg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
