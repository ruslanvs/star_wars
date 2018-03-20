//
//  FilmsTableViewController.swift
//  star_wars
//
//  Created by Ruslan Suvorov on 3/19/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

// NON RECURSIVE, MODULARIZED

import UIKit

class FilmsTableViewController: UITableViewController {

    var films = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        StarWarsModel.getAllFilms(completionHandler: { data, response, error in do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers ) as? NSDictionary {
                    if let results = jsonResult["results"] as? NSArray {
                        for film in results {
                            let filmDict = film as! NSDictionary
                            self.films.append( filmDict["title"]! as! String )
                        }
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
        return films.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell()

        cell.textLabel?.text = films[indexPath.row]

        return cell
    }
}
