//
//  ObjectDetectionViewController.swift
//  Swift Co-Pilot
//
//  Created by Gokul Nair on 10/08/21.
//

import UIKit
import CoreML
import Vision
import VisionKit
import ImageIO

class ObjectDetectionViewController: UIViewController {
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var showCodeBtn: UIButton!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var clearBtn: UIButton!
    
    private var detectedElements = [String]()
    private var swiftCodes = [String]()
    private var swiftUICode = [String]()
    
    private var finalSwiftCode = String()
    private var swiftUIFinalCode = String()
    
    private var isAddImageMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgImage.loadGif(name: "gif")
        selectedImage.layer.cornerRadius = 25
        showCodeBtn.layer.cornerRadius = 10
        clearBtn.isHidden = true
        
        showCodeBtn.setTitle("Sketch Down", for: .normal)
    }
    @IBAction func addImage(_ sender: Any) {
        showDataInputType()
    }
    
    @IBAction func showCodeButton(_ sender: Any) {
        
        if isAddImageMode {
            showDataInputType()
        }else {
            if detectedElements.count != 0 {
                generateCode(elements: detectedElements)
            }else {
                errorAlert(mesg: "No Elements detected")
            }
        }
        
    }
    
    @IBAction func clearImage(_ sender: Any) {
        selectedImage.image = UIImage()
        detectedElements.removeAll()
        DispatchQueue.main.async {
            self.showCodeBtn.setTitle("Sketch Down", for: .normal)
            self.isAddImageMode = true
        }
    }
    
    lazy var detectionRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: UIDetector().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processDetections(for: request, error: error)
            })
            request.imageCropAndScaleOption = .scaleFit
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    
    //MARK:- Image Input type Selection
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

//MARK:- Object Detection
extension ObjectDetectionViewController {
    private func updateDetections(for image: UIImage) {
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation!)
            do {
                try handler.perform([self.detectionRequest])
            } catch {
                print("Failed to perform detection.\n\(error.localizedDescription)")
            }
        }
    }
    
    private func processDetections(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                print("Unable to detect anything.\n\(error!.localizedDescription)")
                return
            }
            
            let detections = results as! [VNRecognizedObjectObservation]
            self.drawDetectionsOnPreview(detections: detections)
        }
    }
    
    func drawDetectionsOnPreview(detections: [VNRecognizedObjectObservation]) {
        guard let image = self.selectedImage.image else {
            return
        }
        
        let imageSize = image.size
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
        
        image.draw(at: CGPoint.zero)
        
        detectedElements.removeAll()
        
        for detection in detections {
            
            print(detection.labels.map({"\($0.identifier) confidence: \($0.confidence)"}).joined(separator: "\n"))
            print("------------")
            
            detectedElements.append(detection.labels.map({$0.identifier})[0])
            print(detectedElements)
            
            let boundingBox = detection.boundingBox
            let rectangle = CGRect(x: boundingBox.minX*image.size.width, y: (1-boundingBox.minY-boundingBox.height)*image.size.height, width: boundingBox.width*image.size.width, height: boundingBox.height*image.size.height)
            UIColor(red: 0, green: 1, blue: 0, alpha: 0.4).setFill()
            UIRectFillUsingBlendMode(rectangle, CGBlendMode.normal)
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.selectedImage.image = newImage
        
        Loaf.dismissWheel(loafWheelView: view)
        DispatchQueue.main.async {
            self.showCodeBtn.setTitle("Show Code", for: .normal)
            self.isAddImageMode = false
        }
    }
}

//MARK:- Image Picker Methods
extension ObjectDetectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        selectedImage.image = image!
        updateDetections(for: image!)
        clearBtn.isHidden = false
        
        Loaf.LoafWheel(message: "ML Model Processing", loafWidth: 280, loafHeight: 110, cornerRadius: 20, bgColor1: .orange, bgColor2: .systemPink, fontStyle: "Avenir Medium", fontSize: 17, fontColor: .black, duration: .greatestFiniteMagnitude, wheelStyle: .medium, blurEffect: .light, loafWheelView: view)
    }
}

//MARK:- Code Snippet Provider
extension ObjectDetectionViewController {
    func generateCode(elements: [String]) {
        let totalElements = elements.count
        for i in 0..<totalElements {
            switch elements[i] {
            case "Buttons":
                swiftCodes.append("UIButton")
                swiftUICode.append("SwiftUI Buttons")
            case "Image":
                swiftCodes.append("UIImage")
                swiftUICode.append("SwiftUI Image")
            case "TF":
                swiftCodes.append("UITextField")
                swiftUICode.append("SwiftUI TextField")
            default:
                errorAlert(mesg: "No elements found")
            }
        }
        
        print(swiftCodes)
        print(swiftUICode)
        
        ViewController.resultSnippet.removeAll()
        
        
        finalSwiftCode = self.swiftCodes.joined(separator: "\n")
        swiftUIFinalCode = self.swiftUICode.joined(separator: "\n")
        
        ViewController.resultSnippet.append(finalSwiftCode)
        ViewController.resultSnippet.append(swiftUIFinalCode)
        
        self.performSegue(withIdentifier: keys.valueOf.ObjectDetToResultVC, sender: nil)
    }
}
