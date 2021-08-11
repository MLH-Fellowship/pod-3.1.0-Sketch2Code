//
//  HistoryTableViewController.swift
//  Swift Co-Pilot
//
//  Created by Prabaljit Walia on 11/08/21.
//

import UIKit

class HistoryTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var titles:[String] = []
    var codes:[String] = []

    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        newGet()


    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        cell.titleLabel.text = titles[indexPath.row]
        cell.codeTextView.text = codes[indexPath.row]
        return cell
    }



}
extension HistoryTableViewController{
    func newGet(){
             let session = URLSession.shared
                     let url = URL(string: "http://sketch2code.tech/history")!
                     let task = session.dataTask(with: url, completionHandler: { data, response, error in
                         
                         if error != nil {
                             print(error)
                             return
                         }
                         
                         do {
                             let json = try JSONDecoder().decode(Result.self, from: data! )
                                 //try JSONSerialization.jsonObject(with: data!, options: [])
                            let totalCodes = json.ip_address.count
                            for i in 0..<totalCodes {
                                print("Title:\(json.ip_address[i].title)")
                                print("Code:\(json.ip_address[i].code)")
                                self.titles.append(json.ip_address[i].title)
                                self.codes.append(json.ip_address[i].code)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                            print("WORKING: \(self.titles)")
                           
                            //print(json)
                         } catch {
                             print("Error during JSON serialization: \(error)")
                         }
                         
                     })
                     task.resume()
         }
}
