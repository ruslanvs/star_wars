//
//  PeopleTableViewController.swift
//  star_wars
//
//  Created by Ruslan Suvorov on 3/19/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    
    var people = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL( string: "http://swapi.co/api/people/" )
//        let session = URLSession.shared
//        let task = session.dataTask( with: url!, completionHandler: {
//            data, response, error in
//            do {
//                if let jsonResult = try JSONSerialization.jsonObject( with: data!, options: JSONSerialization.ReadingOptions.mutableContainers ) as? NSDictionary {
//                    if let results = jsonResult["results"] {
//
//                        let resultsArray = results as! NSArray
//
//                        for p in resultsArray {
//                            let name = (p as! NSDictionary )["name"] as! String
//                            self.people.append( name )
//                        }
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
//                    }
//                    print( jsonResult )
//                    print( jsonResult["next"]! )
//                    print( jsonResult["count"]! )
//                }
//            } catch {
//                print( error )
//            }
//            print( "people count is: \(self.people.count)" )
//        } )
//        task.resume()
        recursiveQuery( url: url )
    }
    
    func recursiveQuery( url: URL? ){
        let session = URLSession.shared
        let task = session.dataTask( with: url!, completionHandler: {
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject( with: data!, options: JSONSerialization.ReadingOptions.mutableContainers ) as? NSDictionary {
                    if let results = jsonResult["results"] {
                        
                        let resultsArray = results as! NSArray
                        
                        for p in resultsArray {
                            let name = (p as! NSDictionary )["name"] as! String
                            self.people.append( name )
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    if let n = jsonResult["next"] as? String {
                        let u = URL( string: n )
                        self.recursiveQuery( url: u )
                    }
                }
            } catch {
                print( error )
            }
            print( "count is: \(self.people.count)" )
        } )
        task.resume()
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
