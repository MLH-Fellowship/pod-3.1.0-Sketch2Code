//
//  CodeSnippets.swift
//  Swift Co-Pilot
//
//  Created by Gokul Nair on 13/08/21.
//

import Foundation

class snippets {
    static let get = snippets()
    
    let buttons =  [ """
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
    
    let labels =  [ """
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
    
    let textField =  [ """
            let textField = UITextField()
textField.frame = CGRect(x:0, y:0, width: 100, height: 40)
textField.placeholder = "Placeholder string"
textField.secureTextEntry = false
textField.text.color = UIColor.black
textField.backGroundColor = UIColor.yellow
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
    
    let textView =   ["""
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
    
    let switches = ["""
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
    
    let views =    ["""
        
        let myNewView=UIView(frame: CGRect(x: 10, y: 100, width: 300, height: 200))
        myNewView.backgroundColor=UIColor.lightGray
        myNewView.layer.cornerRadius=25
        myNewView.layer.borderWidth=2
        myNewView.layer.borderColor = UIColor.red.cgColor
        self.view.addSubview(myNewView)
        
""",
                    """
UIView is not present in SwiftUI
"""]
    
    let segments =   ["""

        
        let mySegmentedControl = UISegmentedControl (items: ["One","Two","Three"])
        
        let xPostion:CGFloat = 10
        let yPostion:CGFloat = 150
        let elementWidth:CGFloat = 300
        let elementHeight:CGFloat = 30
        
        mySegmentedControl.frame = CGRect(x: xPostion, y: yPostion, width: elementWidth, height: elementHeight)
        mySegmentedControl.selectedSegmentIndex = 1
        mySegmentedControl.tintColor = UIColor.yellow
        mySegmentedControl.backgroundColor = UIColor.black
        mySegmentedControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        
        self.view.addSubview(mySegmentedControl)
    
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
    
    let image = ["""
let testImage = UIImageView()
testImage.frame = CGRect(X:0, y:0, width: 100, height: 100)
testImage.image = UIImage(named:"Image Name")
testImage.layer.cornerRadius = 20
testImage.layer.borderColor = UIColor.black.cgColor
testImage.layer.borderWidth = 20
view.addSubview(testImage)
""","""
SwiftUI code for UIImageView
"""]
    
    let buttonCircle = ["UIButton in Circle","Button in Circle"]
    
    let buttonTriangle = ["UIButton in Triangle","Button in Triangle"]
    
    let viewCircle = ["View in circle shape","UIView is not present in SwiftUI"]
    
    let viewTriangle = ["View in triangle shape", "UIView is not present in SwiftUI"]
}
