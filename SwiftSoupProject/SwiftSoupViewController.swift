//
//  ViewController.swift
//  SwiftSoupProject
//
//  Created by MacBook on 26.01.2022.
//

import UIKit
import SwiftSoup

class SwiftSoupViewController: UIViewController {
    
    let urlString = "https://www.avenga.com/career/ukraine/all-openings/"
    var array: [String] = []

    
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func parseHTML() {
        guard let url = URL(string: urlString) else { return }
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8) // all html code
            //Parsing
            do {
                let document = try SwiftSoup.parse(html)
                do {
                    let element = try document.select("span").array()
                    //print("element is \(element)")
                    do {
                        for index in stride(from: 8, to: element.count - 1, by: 3) {
                            let position = try element[index].text()
                            if position == "Apply proactively" {
                                break
                            } else {
                                array.append(position)
                            }
                        }
                    } catch let error as NSError { print(error)}
                } catch let error as NSError { print(error)}
            } catch let error as NSError { print("Problem with parsing \(error)")}
        } catch let error as NSError { print("There is an error with html string \(error)") }
    }


}

