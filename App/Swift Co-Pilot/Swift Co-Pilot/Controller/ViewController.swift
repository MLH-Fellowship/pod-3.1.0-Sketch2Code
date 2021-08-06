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
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var scanBtn: UIButton!
    
    private var request = VNRecognizeTextRequest(completionHandler: nil)
    private let buttonDetector = buttonShapeDetector()
    private var selectedImage = UIImageView()
    private var elementDetected = String()
    static var resultSnippet = [String()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanBtn.layer.cornerRadius = 14
    }
    
    @IBAction func testBtn(_ sender: UIButton) {
        alamoGet()
//        newGet()
    }
    @IBAction func scanButton(_ sender: Any) {
        showDataInputType()
    }
    
    func showDataInputType() {
        let alert = UIAlertController(title: "Input mode", message: "Select a input mode", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            let scannerViewController = VNDocumentCameraViewController()
            scannerViewController.delegate = self
            self.present(scannerViewController, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.setupImageSelection()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func setupImageSelection(){
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        selectedImage.image = image!
        setupVisionTextRecognition(image: image)
        
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
            print("error")
            return
        }
    }
    //MARK:- Shape Classifier
    
    func buttonImageClassifier(){
        
        var inputImage = [buttonShapeDetectorInput]()
        
        if let image = selectedImage.image{
            let newImage =  buffer(from: selectedImage.image!)
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
UITextView
""",
                 """
SwiftUI code for UItextView
"""]
        case 5:
            ViewController.resultSnippet =
                ["""
UISwitch
""",
                 """
SwiftUI code for UISwitch
"""]
        case 6:
            ViewController.resultSnippet =
                ["""
UIView
""",
                 """
UIView is not present in SwiftUI
"""]
        case 7:
            ViewController.resultSnippet =
                ["""
UISegment Control
""",
                 """
SwiftUI code for UISegment Control
"""]
        default:
            break
        }
        
        self.performSegue(withIdentifier: keys.valueOf.scanToResultVC, sender: nil)
    }
    //MARK:-GET
    func alamoGet(){
        let request = AF.request("http://sketch2code.tech/history")
            // 2
        request.responseJSON { (data) in
            print(data)
            }
        //use this when ip address is added to API 
//        request.responseDecodable(of: Result.self) { (response) in
//          guard let results = response.value else { return }
//          print(results.code)
//        }
    }

}
