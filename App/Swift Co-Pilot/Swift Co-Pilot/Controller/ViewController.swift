//
//  ViewController.swift
//  Swift Co-Pilot
//
//  Created by Prabaljit Walia on 29/07/21.
//

import UIKit
import Vision
import VisionKit
import CoreML
import ImageIO
import SwiftUI

class ViewController: UIViewController {
    
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var clearBtn: UIButton!
    
    private var request = VNRecognizeTextRequest(completionHandler: nil)
    private let buttonDetector = buttonShapeDetector()
    private var elementDetected = String()
    static var resultSnippet = [String()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanBtn.layer.cornerRadius = 10
        testImage.layer.cornerRadius = 25
        clearBtn.isHidden = true
        
        bgImage.loadGif(name: "gif")
        
        tabBarController?.tabBar.backgroundImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    @IBAction func settingsView(_ sender: Any) {
        let vc = UIHostingController(rootView: SetttingsTab())
        present(vc, animated: true)
    }
    @IBAction func scanButton(_ sender: Any) {
        showDataInputType()
    }
    @IBAction func clearImageButton(_ sender: Any) {
        testImage.image = UIImage()
    }
    
    func showDataInputType() {
        let alert = UIAlertController(title: "Input mode", message: "Select a input mode", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.setupImageSelection(type: "camera")
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.setupImageSelection(type: "gallery")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

//MARK:- Image Picker Methods
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func setupImageSelection(type: String){
        
        if type == "gallery" {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }else if type == "camera" {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true)
        }else {
            print("cancel")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        testImage.image = image
        setupVisionTextRecognition(image: image)
        clearBtn.isHidden = false
        
        Loaf.LoafWheel(message: "Processing", loafWidth: 280, loafHeight: 110, cornerRadius: 20, bgColor1: .orange, bgColor2: .systemPink, fontStyle: "Avenir Medium", fontSize: 17, fontColor: .black, duration: .greatestFiniteMagnitude, wheelStyle: .medium, blurEffect: .light, loafWheelView: view)
    }
    
    private func setupVisionTextRecognition(image: UIImage?){
        //indicator.startAnimating()
        var textString = ""
        
        request = VNRecognizeTextRequest(completionHandler: { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else{fatalError("Recived invalid observation")}
            
            for observation in observations{
                guard let topCandidate = observation.topCandidates(1).first else {
                    print("No Candidate") 
                    continue
                }
                textString += "\n\(topCandidate.string)"
                DispatchQueue.main.async {
                    //  self.capturedText = textString
                    self.identifyElement(text: textString)
                    // self.indicator.stopAnimating()
                }
            }
        })
        ///add properties
        request.customWords = ["custOm"]
        request.minimumTextHeight = 0.03125
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["en_US"]
        request.usesLanguageCorrection = true
        
        let requests = [request]
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let images = image?.cgImage else {
                fatalError("Missing Image to scan")}
            let handle = VNImageRequestHandler(cgImage: images, options: [:])
            try?handle.perform(requests)
        }
        
    }
}

//MARK:- Scan Document Method

extension ViewController: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        let image = scan.imageOfPage(at: 0)
        setupVisionTextRecognition(image: image)
        controller.dismiss(animated: true, completion: nil)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        //alert
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
    }
}

//MARK:- ML Model Application
extension ViewController {
    func identifyElement(text: String) {
        elementDetected = text.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch elementDetected {
        case "button":
            buttonImageClassifier()
            return
        case "label":
            codeSnippet(snippetNo: 2)
            return
        case "textfield":
            codeSnippet(snippetNo: 3)
            return
        case "textview":
            codeSnippet(snippetNo: 4)
            return
        case "switch":
            codeSnippet(snippetNo: 5)
            return
        case "view":
            buttonImageClassifier()
            return
        case "segment":
            codeSnippet(snippetNo: 7)
            return
        default:
            Loaf.dismissWheel(loafWheelView: view)
            print("error")
            return
        }
    }
    //MARK:- Shape Classifier
    
    func buttonImageClassifier(){
        
        var inputImage = [buttonShapeDetectorInput]()
        
        if let image = testImage.image{
            let newImage =  buffer(from: testImage.image!)
            let imageForClassification = buttonShapeDetectorInput(image: newImage!)
            inputImage.append(imageForClassification)
        }
        do {
            let prediction = try self.buttonDetector.predictions(inputs: inputImage)
            
            for result in prediction{
                let res = result.classLabel
                
                if res == keys.valueOf.circle{
                    snippetAllocator(with: res)
                    print("ml model detected circle")
                }
                else if res == keys.valueOf.square{
                    snippetAllocator(with: res)
                    print("ml model detected square")
                }
                else if res == keys.valueOf.triangle{
                    print("ml model detected triangle")
                }
                else {
                    // Provide default code for identified UIElement
                    print("ml model detected nil")
                }
            }
            
        }catch{
            print("error found\(error)")
        }
    }
    
    //MARK:- Snippet allocator
    /// Providing Snippet according to the element type and its shape detected
    func snippetAllocator(with shape: String) {
        switch elementDetected {
        case "button":
            if shape == keys.valueOf.square {
                codeSnippet(snippetNo: 1)
            }
            else if shape == keys.valueOf.circle{
                // code snippet with button of circular shape
            }
            else if shape == keys.valueOf.triangle {
                // code snippet with button of triangular shape
            }
            return
        case "view":
            if shape == keys.valueOf.square {
                codeSnippet(snippetNo: 6)
            }
            else if shape == keys.valueOf.circle {
                
                // code snippet with view of circular shape
            }
            else if shape == keys.valueOf.triangle {
                // code snippet with button of triangular shape
            }
            return
        default:
            break
        }
    }
    
    //MARK:-  Code Snippet Provider
    
    func codeSnippet(snippetNo: Int) {
        switch snippetNo {
        case 1:
            ViewController.resultSnippet =
                [ """
            let button = UIButton()
            button.frame = CGRect(x: view.center.x, y: view.center.y, width: 100, height: 100)
            button.setTitle("", for: .normal)
            button.layer.cornerRadius = 0
            button.layer.borderWidth = 0
            button.layer.borderColor = UIColor.clear.cgColor
""",
                  """
                              Button(action:{
                                  //do something when button is tapped
                              }){
                                  Text("Title")
                              }.padding()
                              .foregroundColor(.blue)
                              .background(Rectangle().fill(Color.white))
                             //adjust width, height or alignment
                              .frame(width: 100, height: 100)
  """]
        case 2:
            ViewController.resultSnippet =
                [ """
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label.center = CGPoint(x: 160, y: 285)
            label.textAlignment = .center
            label.text = "I'm a test label"
            self.view.addSubview(label)
""",
                  """
              Label("SwiftUI Label", systemImage: "book.fill")
                .labelStyle(TitleOnlyLabelStyle())
  """]
        case 3:
            ViewController.resultSnippet =
                [ """
            UITextField
""",
                  """
              struct ContentView: View {
                  @State var username: String = ""
                  
                  var body: some View {
                      VStack(alignment: .leading) {
                          TextField("Enter username...", text: $username)
                      }.padding()
                  }
              }
  """]
        case 4:
            ViewController.resultSnippet =
                ["""
let textView = UITextView(frame: CGRect(x: 20.0, y: 90.0, width: 250.0, height: 100.0))
textView.contentInsetAdjustmentBehavior = .automatic
textView.center = self.view.center
textView.textAlignment = NSTextAlignment.justified
textView.textColor = UIColor.blue
textView.backgroundColor = UIColor.lightGray
""",
                 """
Text("Add your text")
"""]
        case 5:
            ViewController.resultSnippet =
                ["""
UISwitch
  override func viewDidLoad() {
        super.viewDidLoad()
        
        let switchDemo=UISwitch(frame:CGRect(x: 150, y: 150, width: 0, height: 0))
        switchDemo.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
        switchDemo.setOn(true, animated: false)
        self.view.addSubview(switchDemo)
        
    }
    
    @objc func switchStateDidChange(_ sender:UISwitch!)
    {
        if (sender.isOn == true){
            //action when switch is on
        }
        else{
            //action when switch is off
        }
    }
""",
                 """
Toggle("Optional Message", isOn: $stateBinding)
                .toggleStyle(SwitchToggleStyle(tint: .green))
"""]
        case 6:
            ViewController.resultSnippet =
                ["""
UIView:
override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let myNewView=UIView(frame: CGRect(x: 10, y: 100, width: 300, height: 200))
        
        // Change UIView background colour
        myNewView.backgroundColor=UIColor.lightGray
        
        // Add rounded corners to UIView
        myNewView.layer.cornerRadius=25
        
        // Add border to UIView
        myNewView.layer.borderWidth=2
        
        // Change UIView Border Color to Red
        myNewView.layer.borderColor = UIColor.red.cgColor
        
        // Add UIView as a Subview
        self.view.addSubview(myNewView)
        
    }
""",
                 """
UIView is not present in SwiftUI
"""]
        case 7:
            ViewController.resultSnippet =
                ["""
UISegment Control:
override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let mySegmentedControl = UISegmentedControl (items: ["One","Two","Three"])
        
        let xPostion:CGFloat = 10
        let yPostion:CGFloat = 150
        let elementWidth:CGFloat = 300
        let elementHeight:CGFloat = 30
        
        mySegmentedControl.frame = CGRect(x: xPostion, y: yPostion, width: elementWidth, height: elementHeight)
        
        // Make second segment selected
        mySegmentedControl.selectedSegmentIndex = 1
        
        //Change text color of UISegmentedControl
        mySegmentedControl.tintColor = UIColor.yellow
        
        //Change UISegmentedControl background colour
        mySegmentedControl.backgroundColor = UIColor.black
        
        // Add function to handle Value Changed events
        mySegmentedControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        
        self.view.addSubview(mySegmentedControl)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
    //action when values are changed
    }

""",
                 """
struct ContentView: View {
    @State private var favoriteColor = 0

    var body: some View {
        VStack {
            Picker(selection: $favoriteColor, label: Text("What is your favorite color?")) {
                Text("Red").tag(0)
                Text("Green").tag(1)
                Text("Blue").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}
"""]
        default:
            break
        }
        
        self.performSegue(withIdentifier: keys.valueOf.scanToResultVC, sender: nil)
        Loaf.dismissWheel(loafWheelView: view)
    }
    
}
