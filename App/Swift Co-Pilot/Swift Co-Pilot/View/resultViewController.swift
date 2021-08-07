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
        resultView.layer.cornerRadius = 25
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
        Loaf.GradientLoaf(message: "Snippet Saved", position: .bottom, loafWidth: 300, loafHeight: 45, cornerRadius: 14, fontStyle: "Avenir Medium", fontSize: 18, bgColor1: .systemOrange, bgColor2: .systemPink, fontColor: .black, loafImage: nil, animationDirection: .Bottom, duration: 3.0, loafjetView: view)
        self.post()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
            self.dismiss(animated: true, completion: nil)
        })
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
