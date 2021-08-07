//
//  TextToCodeViewController.swift
//  Swift Co-Pilot
//
//  Created by Gokul Nair on 04/08/21.
//

import UIKit

class TextToCodeViewController: UIViewController {
    
    @IBOutlet weak var textInputView: UITextView!
    @IBOutlet weak var suggestionTV: UITextView!
    @IBOutlet weak var compileBtn: UIButton!
    
    var words = String()
    var elementSuggestion = String()
    var listOfText = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textInputView.delegate = self
        textInputView.layer.cornerRadius = 25
        suggestionTV.layer.cornerRadius = 25
        
        compileBtn.layer.cornerRadius = 14
    }
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func compileButton(_ sender: Any) {
        textToCode()
    }
    
    @IBAction func abbreviationViewButton(_ sender: Any) {
        let SB = storyboard?.instantiateViewController(identifier: keys.valueOf.abbreviationVC) as! abbreviationViewController
        SB.modalPresentationStyle = .overFullScreen
        present(SB, animated: true, completion: nil)
    }
}
//MARK:- Text Parser
extension TextToCodeViewController {
    func textToCode() {
        listOfText.removeAll()
        words = ""
        for i in textInputView.text {
            words += String(i)
            if i == " " {
                listOfText.append(words)
                words = ""
            }
        }
        print(listOfText)
        checkElement(text: listOfText)
    }
    
    func checkElement(text: [String]) {
        guard text.count != 0 else {
            errorAlert(mesg: "Check your input!")
            return
        }
        
        let inputText = text[0].lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch inputText {
        case "button":
            buttonCodeGenerator(input: listOfText)
            print("here")
        case "label":
            labelCodeGenerator(input: listOfText)
        default:
            errorAlert(mesg: "UIElement type is wrong")
        }
    }
    //MARK:- Code Generator
    func buttonCodeGenerator(input: [String]) {
        if listOfText.count == 7 {
            ViewController.resultSnippet =
                ["""
                let button = UIButton()
                button.frame = CGRect(x: view.center.x, y: view.center.y, width: \(input[2]), height: \(input[3])
                button.setTitle("", for: .normal)
                button.layer.cornerRadius = \(input[4])
                button.layer.borderWidth = \(input[5])
                button.layer.borderColor = UIColor.\(input[6]).cgColor
    """, """
    SwiftUI Code
    
    """]
            finalProcess()
        }else {
            errorAlert(mesg: "You are missing a parameter, Do follow the rule book!")
        }
    }
    
    func labelCodeGenerator(input: [String]) {
        if listOfText.count == 5 {
            ViewController.resultSnippet =
                ["""
              let label = UILabel()
              label.textColor = UIColor.\(input[1])
              label.frame = CGRect((x: view.center.x, y: view.center.y, width: \(input[2]), height: \(input[3]))
            label.backgroundColor = UIColor.\(input[4])
            test.font = UIFont(name: \(input[6]), size: \(input[5])
    
    """, """
    SwiftUI Code
    """]
            finalProcess()
        }else {
            errorAlert(mesg: "You are missing a parameter, Do follow the rule book!")
        }
        
    }
    
    //  Final process after text is parsed
    func finalProcess() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: keys.valueOf.textToResultVC, sender: nil)
            self.listOfText.removeAll()
        }
    }
}
//MARK:- Suggestion Box
extension TextToCodeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        elementSuggestion = textView.text.components(separatedBy: " ").first ?? ""
        
        switch elementSuggestion.lowercased() {
        case "button":
            self.suggestionTV.text = "button\n E C W H Cr B Bc"
        case "label":
            self.suggestionTV.text = "Label\n E C W H Bc P Fs"
        default:
            self.suggestionTV.text = "Detecting...."
        }
        
    }
}
