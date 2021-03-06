//
//  Parent.swift
//  Parent
//
//  Created by Sven Svensson on 27/08/2021.
//

import Foundation
import SwiftUI

// Data Model
struct Parent: Identifiable, Equatable, Hashable {
    var id: UUID
    var name: String
    var children:[Child]
}

extension Parent {
    struct Data {
        var name: String = ""
        var children: [Child] = [Child]()
        
        mutating func remove(_ child: Child)  {
            guard let _index = children.firstIndex(where: { $0.id == child.id}) else {
                print("Parent.Data: delete: child not found?")
                return
            }
            children.remove(at: _index)
        }
        
        mutating func createChild(by data: Child.Data) {
            let newChild = Child(
                id: UUID(),
                name: data.name,
                toys: data.toys
            )
            
            children.append(newChild)
        }
    }
    
    var data: Data { return Data(name: name, children: children)}
    
    mutating func update(from data: Parent.Data) {
        self.name = data.name
        self.children = data.children
    }
    
    static var data: [Parent] {
    [
        Parent(id: UUID(uuidString: "5D61566D-8239-4F16-B84C-D659D25249B6")!, name: "Bruce",
               children: [Child.data[0], Child.data[1]]),
        Parent(id: UUID(uuidString: "3455749B-ED54-45E4-937D-3A46C3461F92")!, name: "Steve Jobs",
               children: [Child.data[2]]),
        
    ]}
    
    static var zero: Parent = Parent(id: UUID.zero, name: "", children: [Child]())
    
    /// SF-Symbol
    static var symbol = "person"
    
}


