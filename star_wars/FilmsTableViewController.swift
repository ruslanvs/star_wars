//
//  FilmsTableViewController.swift
//  star_wars
//
//  Created by Ruslan Suvorov on 3/19/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

class FilmsTableViewController: UITableViewController {

    var films = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL( string: "http://swapi.co/api/films/" )
        recursiveQuery( url: url )
    }

    func recursiveQuery( url: URL? ){
        let session = URLSession.shared
        let task = session.dataTask( with: url!, completionHandler:{
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject( with: data!, options: JSONSerialization.ReadingOptions.mutableContainers ) as? NSDictionary {
                    if let results = jsonResult["results"] {

                        let resultsArray = results as! NSArray

                        for i in resultsArray {
                            let film = ( i as! NSDictionary  )["title"] as! String
                            self.films.append( film )
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
            print( "film count is: \(self.films.count)" )
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
        return films.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell()

        cell.textLabel?.text = films[indexPath.row]

        return cell
    }
}
