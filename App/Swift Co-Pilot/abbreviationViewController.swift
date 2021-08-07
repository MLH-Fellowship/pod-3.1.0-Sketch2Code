//
//  abbreviationViewController.swift
//  Swift Co-Pilot
//
//  Created by Gokul Nair on 07/08/21.
//

import UIKit

class abbreviationViewController: UIViewController {

    @IBOutlet weak var abbreviationTV: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dismiss: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.addSubview(abbreviationTV)
        view.addSubview(titleLabel)
        view.addSubview(dismiss)
        
        abbreviationTV.layer.cornerRadius = 25
        
        abbreviationTV.text = "E: UIElement Type\nC: Element Color\nW: Width\nH: Height\nCr: Corner Radius\nB: Border Width\nBc: Background Color\nP: Point Size\nFs: Font Style"
    }
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
}
