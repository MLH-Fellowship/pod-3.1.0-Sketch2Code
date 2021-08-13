//
//  CodeDetailViewController.swift
//  Swift Co-Pilot
//
//  Created by Prabaljit Walia on 12/08/21.
//

import UIKit

class CodeDetailViewController: UIViewController {
    var codeDes = ""
    var navTitle = ""
    
    @IBOutlet weak var codeDetailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "\(navTitle)"
        codeDetailTextView.text = "\(codeDes)"
    }
    
    @IBAction func copyCode(_ sender: Any) {
        UIPasteboard.general.string = codeDetailTextView.text
        Loaf.GradientLoaf(message: "Snippet Copied", position: .top, loafWidth: 280, loafHeight: 45, cornerRadius: 14, fontStyle: "Avenir Medium", fontSize: 18, bgColor1: .systemOrange, bgColor2: .systemPink, fontColor: .black, loafImage: nil, animationDirection: .Top, duration: 3.0, loafjetView: view)
    }
}
