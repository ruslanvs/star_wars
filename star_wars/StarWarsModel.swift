//
//  StarWarsModel.swift
//  star_wars
//
//  Created by Ruslan Suvorov on 3/20/18.
//  Copyright © 2018 Ruslan Suvorov. All rights reserved.
//

import Foundation
class StarWarsModel {
    
    static func getAllPeople( _ url: URL?, completionHandler: @escaping ( _ data: Data?, _ response: URLResponse?, _ error: Error? ) -> Void ){
        // let url = URL( string: "http://swapi.co/api/people/" )
        
        let session = URLSession.shared
        let task = session.dataTask( with: url!, completionHandler: completionHandler )
        task.resume()
    }
    
    static func getAllFilms( completionHandler: @escaping ( _ data: Data?, _ response: URLResponse?, _ error: Error? ) -> Void ){
        let url = URL( string: "http://swapi.co/api/films/" )
        let session = URLSession.shared
        let task = session.dataTask( with: url!, completionHandler: completionHandler )
        task.resume()
    }
}
