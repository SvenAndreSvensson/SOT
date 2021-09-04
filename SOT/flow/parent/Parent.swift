//
//  Parent.swift
//  Parent
//
//  Created by Sven Svensson on 27/08/2021.
//

import Foundation

// Data Model
struct Parent: Identifiable, Equatable {
    var id: UUID
    var name: String
    var children:[Child]
    
}

// ViewModel - must have a default value
extension Parent {
    
}

extension Parent {
    struct Data {
        var name: String = ""
        var children: [Child] = [Child]()
        
        mutating func remove(_ child: Child) -> Child? {
            guard let _index = children.firstIndex(where: { $0.id == child.id}) else {
                print("Parent.Data: delete: child not found?")
                return nil
            }
            return children.remove(at: _index)
        }
    }
    
    var data: Data { return Data(name: name, children: children)}
    
    mutating func update(from data: Parent.Data) {
        self.name = data.name
        self.children = data.children
    }
    
    static var data: [Parent] {
    [
        Parent(id: UUID(uuidString: "5D61566D-8239-4F16-B84C-D659D25249B6")!, name: "Parent one",
               children: [Child.data[0], Child.data[1]]),
        Parent(id: UUID(uuidString: "3455749B-ED54-45E4-937D-3A46C3461F92")!, name: "Parent two",
               children: [Child.data[1], Child.data[2]]),
        Parent(id: UUID(uuidString: "ACB8CEB6-9B37-4855-9799-56510771B534")!, name: "Parent three",
               children: [Child.data[0], Child.data[2]]),
    ]}
    
    static var zero: Parent = Parent(id: UUID.zero, name: "", children: [Child]())
}


