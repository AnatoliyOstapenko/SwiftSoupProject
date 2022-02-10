//
//  Manager.swift
//  SwiftSoupProject
//
//  Created by MacBook on 05.02.2022.
//

import Foundation
import SwiftSoup

// create protocol with class AnyObject
protocol ManagerDelegate: class {
    func updateUI(_ data: String)
}

struct Manager {
    
    
    weak var managerDelegate: ManagerDelegate? // weak reference to protocol (ARC)
        
    func parseHTML(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8) // get all html code
            //Parsing
            let document = try SwiftSoup.parse(html)
            let element = try document.select("span").array()
            //print("element is \(element)")
            
            for index in stride(from: 8, to: element.count - 1, by: 3) {
                let position = try element[index].text()
                if position == "Apply proactively" {
                    break
                } else {
                    managerDelegate?.updateUI(position)

                }
            }
        } catch let error as NSError { print(error)}
    }
    
}




