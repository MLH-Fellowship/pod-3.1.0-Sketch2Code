//
//  resultViewController.swift
//  Swift Co-Pilot
//
//  Created by Gokul Nair on 30/07/21.
//

import UIKit
import Alamofire

class resultViewController: UIViewController, UITextFieldDelegate {
    var count = 7

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var resultView: UITextView!
    @IBOutlet weak var bgImage: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.layer.cornerRadius = 25
        resultView.layer.borderColor = UIColor.white.cgColor
        resultView.layer.borderWidth = 1
        resultView.text = ViewController.resultSnippet[0]
        bgImage.loadGif(name: "gif")
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
    
    
    @IBAction func saveButton(_ sender: Any) {
        UIPasteboard.general.string = resultView.text
       addCodeSnippet()
    }
    
    func addCodeSnippet() {
        let alert = UIAlertController(title:"Save Code", message: "Add Code snippet title", preferredStyle:UIAlertController.Style.alert)

               alert.addTextField { (textField : UITextField!) in
                   textField.placeholder = "Code title"
                textField.delegate = self
                
               }
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            
            guard let fields = alert.textFields, fields.count == 1 else {
                
                return
            }
            
            let titleText = fields[0]
            guard let title = titleText.text, !title.isEmpty else {
                Loaf.PlainLoaf(message: "Error!", position: .top, loafWidth: 250, loafHeight: 40, cornerRadius: 14, fontStyle: "Avenir Medium", fontSize: 18, bgColor: .systemRed, fontColor: .white, alphaValue: 0.9, loafImage: nil, animationDirection: .Top, duration: 3.0, loafjetView: self.view)
                return
            }
            
            self.post(title: title)
            
            Loaf.GradientLoaf(message: "Snippet Saved", position: .top, loafWidth: 280, loafHeight: 45, cornerRadius: 14, fontStyle: "Avenir Medium", fontSize: 18, bgColor1: .systemOrange, bgColor2: .systemPink, fontColor: .black, loafImage: nil, animationDirection: .Top, duration: 3.0, loafjetView: self.view)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                self.navigationController?.popViewController(animated: true)
            })
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension resultViewController{
    func post(title: String){
            
        let parameters = ["title": title, "code": ViewController.resultSnippet[0]]
        let header:HTTPHeaders = ["Content-Type":"application/json"]
        AF.request("http://sketch2code.tech/history", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON{(response) in
            print(response)
        }
    }

}
