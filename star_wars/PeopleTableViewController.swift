//
//  PeopleTableViewController.swift
//  star_wars
//
//  Created by Ruslan Suvorov on 3/19/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

// RECURSIVE, KIND OF MODULARIZED

import UIKit

class PeopleTableViewController: UITableViewController {
    
    var people = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL( string: "http://swapi.co/api/people/" )
        recursiveQuery( url: url )
    }
    
    func recursiveQuery( url: URL? ){
        StarWarsModel.getAllPeople(  url, completionHandler: { data, response, error in do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers ) as? NSDictionary {
                    if let results = jsonResult["results"] as? NSArray {
                        for person in results {
                            let personDict = person as! NSDictionary
                            self.people.append( personDict["name"]! as! String )
                        }
                    }
                if let n = jsonResult["next"] as? String {
                    let u = URL( string: n )
                    self.recursiveQuery( url: u )
                }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print( "Something went wrong" )
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell()
        
        cell.textLabel?.text = people[indexPath.row]
        
        return cell
    }
}
