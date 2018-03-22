//
//  Person.swift
//  star_wars
//
//  Created by Ruslan Suvorov on 3/20/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import UIKit

class Person: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var personDict: NSDictionary?
    var person = NSDictionary()
    var personKeysArr = [String]()
    var personValuesArr = [String]()
    
    

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        if let p = personDict {
            person = p
            nameLabel.text = person.value(forKey: "name") as? String
//            print ( person )
            
            for item in person {
                personKeysArr.append( String(describing: item.key) )
                personValuesArr.append( String(describing: item.value) )
            }
            print( personValuesArr[6])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension Person: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personKeysArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "personDetails", for: indexPath )
        cell.textLabel?.text = "\(personKeysArr[indexPath.row]): \(personValuesArr[indexPath.row])"
        return cell
    }

}
