//
//  resultViewController.swift
//  Swift Co-Pilot
//
//  Created by Gokul Nair on 30/07/21.
//

import UIKit

class resultViewController: UIViewController {

    @IBOutlet weak var resultView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        resultView.text = ViewController.resultSnippet
    }
    

}
