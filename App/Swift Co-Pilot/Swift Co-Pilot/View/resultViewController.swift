//
//  resultViewController.swift
//  Swift Co-Pilot
//
//  Created by Gokul Nair on 30/07/21.
//

import UIKit
import Alamofire

class resultViewController: UIViewController {
    var count = 7

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var resultView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        resultView.text = ViewController.resultSnippet[0]
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            resultView.text = ViewController.resultSnippet[0]
        case 1:
            resultView.text = ViewController.resultSnippet[1]
        default:
            break
        }
    }
    
    @IBAction func copyBtn(_ sender: UIButton) {
        UIPasteboard.general.string = resultView.text
        post()
    }
    
}

extension resultViewController{
        func post(){
            
        let parameters = ["title": "UIB-\(count)", "code": ViewController.resultSnippet[0]]
        let header:HTTPHeaders = ["Content-Type":"application/json"]
        AF.request("http://sketch2code.tech/history", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON{(response) in
            print(response)
            self.count += 1
        }
    }

}
