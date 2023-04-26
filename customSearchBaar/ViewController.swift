//
//  ViewController.swift
//  customSearchBaar
//
//  Created by Mohan K on 24/02/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    let allTable = ["ironMan", "CaptainAmerica", "Thor","Hulk", "BlackWidow", "Kawl", "Falcon", "Winter soldier", "loki", "doctorstrange", "Gwen", "peterpARKER", "SpiderMan", "wanda", "BlackPanther","captcai","Nebul", "wasp", "Antman", "thanos", "Stanlee", "scarellete witch", "QuickSilver", "Groot", "starLord", "she Hulk"]
    var avenger = [String]()
    
    @IBOutlet weak var arrayTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.avenger = allTable
        arrayTable.delegate = self
        arrayTable.dataSource = self
        
        arrayTable.reloadData()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        arrayTable.contentInset = .zero
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            arrayTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + arrayTable.rowHeight, right: 0)
        }
    }
        @IBAction func searchHandler(_ sender: UITextField) {
            
            if let searchText = sender.text {
                avenger = searchText.isEmpty ? allTable : allTable.filter{$0.lowercased().contains(searchText.lowercased())}
                arrayTable.reloadData()
            }
         else  {
                avenger = allTable


            }
           
            
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if avenger.count > 0{
                self.arrayTable.backgroundView = nil
                self.arrayTable.separatorStyle = .singleLine
                return avenger.count
            }
//            let rect = CGRect(x: 0,
//                              y: 0,
//                              width: self.arrayTable.bounds.size.width,
//                              height: self.arrayTable.bounds.size.height)
            let nodataLabel : UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: 200, height: 40))
            nodataLabel.numberOfLines = 0
            nodataLabel.text = "NO Result Found.\n\nPlease check your search."
            nodataLabel.textAlignment = NSTextAlignment.center
            self.arrayTable.backgroundView = nodataLabel
            self.arrayTable.separatorStyle = .none
            
            return avenger.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel!.text = avenger[indexPath.row]
            return cell!
        }
        
    }
    
    
