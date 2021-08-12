//
//  SettingsViewController.swift
//  Swift Co-Pilot
//
//  Created by Gokul Nair on 11/08/21.
//

import UIKit
import SwiftUI

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func viewDidAppear(_ animated: Bool) {
        let vc = UIHostingController(rootView: SetttingsTab())
        present(vc, animated: true)
    }
    

}
