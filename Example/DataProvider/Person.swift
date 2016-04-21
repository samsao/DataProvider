//
//  Person.swift
//  DataProvider
//
//  Created by Guilherme Silva Lisboa on 2016-03-16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

class Person {
    var name : String
    var lastName : String
    
    init(name : String, lastName : String) {
        self.name = name
        self.lastName = lastName
    }
    
    
    static func peopleCollection() -> [Person] {
        var people = [Person]()
        var person : Person!
        for i in 0..<10 {
            person = Person(name: "PersonName", lastName: String(i))
            people.append(person)
        }
        return people
    }
    
    func fullName() -> String {
        return name+lastName
    }
    
}

