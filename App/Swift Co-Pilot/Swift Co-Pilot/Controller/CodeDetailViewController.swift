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
    @IBOutlet weak var copyBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "\(navTitle)"
        codeDetailTextView.text = "\(codeDes)"
        copyBtnOutlet.tintColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func copyBtn(_ sender: UIButton) {
        UIPasteboard.general.string = codeDetailTextView.text
        Loaf.GradientLoaf(message: "Snippet Saved", position: .top, loafWidth: 300, loafHeight: 45, cornerRadius: 14, fontStyle: "Avenir Medium", fontSize: 18, bgColor1: .systemOrange, bgColor2: .systemPink, fontColor: .black, loafImage: nil, animationDirection: .Top, duration: 3.0, loafjetView: view)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
