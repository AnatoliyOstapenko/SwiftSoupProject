//
//  ViewController.swift
//  SwiftSoupProject
//
//  Created by MacBook on 26.01.2022.
//

import UIKit



class SwiftSoupViewController: UIViewController {
    
    var manager = Manager()
    var array: [String] = []
    
    var spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .label
        // Setting the autoresizing mask to keep the spinner in the center
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        return indicator
    }()

    @IBOutlet weak var importButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var swiftSoupTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // registration nib
        swiftSoupTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        manager.managerDelegate = self
//        manager.managerProtocol = self
        swiftSoupTableView.dataSource = self
        
        // Add the loadingActivityIndicator in the center of view
        spinner.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(spinner)

    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func importButtonPressed(_ sender: UIBarButtonItem) {
        spinner.startAnimating()
        // set parsing process into other dispatch. avoid freezing screen
        let dispatch = DispatchQueue.global(qos: .utility)
        dispatch.async {
            self.manager.parseHTML(K.urlString)
        }
        
    }
}

// MARK:- Manager Delegate Protocol

extension SwiftSoupViewController: ManagerDelegate {
    func updateUI(_ data: String) {

            array.append(data)
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.swiftSoupTableView.reloadData()
            }
    }
}

// MARK:- TableView Data Source Method

extension SwiftSoupViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.categoryLabel.text = "Category \(indexPath.row)"
        cell.locationLabel.text = "Location \(indexPath.row)"
        cell.positionLabel.text = array[indexPath.row]

        return cell
    }
    
    
}

