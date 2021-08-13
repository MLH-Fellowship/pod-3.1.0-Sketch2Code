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
    
     func setupVisionTextRecognition(image: UIImage?){
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
                    Loaf.dismissWheel(loafWheelView: view)
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
                codeSnippet(snippetNo: 8)
            }
            else if shape == keys.valueOf.triangle {
                codeSnippet(snippetNo: 9)
            }
            return
        case "view":
            if shape == keys.valueOf.square {
                codeSnippet(snippetNo: 6)
            }
            else if shape == keys.valueOf.circle {
                codeSnippet(snippetNo: 10)
            }
            else if shape == keys.valueOf.triangle {
               codeSnippet(snippetNo: 11)
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
            ViewController.resultSnippet = snippets.get.buttons
               
        case 2:
            ViewController.resultSnippet = snippets.get.labels
               
        case 3:
            ViewController.resultSnippet = snippets.get.textField
               
        case 4:
            ViewController.resultSnippet = snippets.get.textView
              
        case 5:
            ViewController.resultSnippet = snippets.get.switches
                
        case 6:
            ViewController.resultSnippet = snippets.get.views
             
        case 7:
            ViewController.resultSnippet = snippets.get.segments
              
        case 8:
            ViewController.resultSnippet = snippets.get.buttonCircle
        case 9:
            ViewController.resultSnippet = snippets.get.buttonTriangle
        case 10:
            ViewController.resultSnippet = snippets.get.viewCircle
        case 11:
            ViewController.resultSnippet = snippets.get.viewTriangle
        default:
            break
        }
        
        self.performSegue(withIdentifier: keys.valueOf.scanToResultVC, sender: nil)
        Loaf.dismissWheel(loafWheelView: view)
    }
    
}
