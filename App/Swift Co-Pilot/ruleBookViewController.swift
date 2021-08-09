//
//  ruleBookViewController.swift
//  Swift Co-Pilot
//
//  Created by Gokul Nair on 06/08/21.
//

import UIKit

class ruleBook {
    var heading:String?
    var rules:[String]?
    
    
    init(heading: String?, rules:[String]?) {
        self.heading = heading
        self.rules = rules
    }
}

class ruleBookViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var rulesScreen = [ruleBook]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        rulesScreen.append(ruleBook.init(heading: "UIBUttons", rules: ["E C W H Cr B Bc"]))
        rulesScreen.append(ruleBook.init(heading: "UILabel", rules: ["E C W H Bc P Fs"]))
    }
}

//MARK:- TableView Methods
extension ruleBookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rulesScreen[section].rules?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return rulesScreen.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: keys.valueOf.rulesCellID, for: indexPath)
        cell.textLabel?.text = rulesScreen[indexPath.section].rules?[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Avenir Medium", size: 18)
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return rulesScreen[section].heading
    }
    
}
