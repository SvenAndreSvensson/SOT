//
//  Child.swift
//  Child
//
//  Created by Sven Svensson on 27/08/2021.
//

import Foundation

struct Child: Identifiable, Equatable, Hashable {
    var id: UUID
    var name: String
    var toys:[Toy]
    
    
}

extension Child {
    struct Data {
        var name: String = ""
        var toys: [Toy] = [Toy]()
        
        mutating func deleteToy(_ toy: Toy) {
            guard let _index = toys.firstIndex(where: { $0.id == toy.id }) else {
                print("Parent.Data: delete: child not found?")
                return
            }
            toys.remove(at: _index)
        }
        
        mutating func createToy(by data: Toy.Data){
            let newToy = Toy(
                id: UUID(),
                name: data.name)
            
            toys.append(newToy)
        }
    }
    
    var data: Data { return Data(name: name, toys: toys)}
    
    
    
    
    mutating func update(from data: Child.Data) {
        self.name = data.name
        self.toys = data.toys
    }
    
    mutating func createToy(by data: Toy.Data) {
        let newToy = Toy(id: UUID(), name: data.name)
        toys.append(newToy)
    }
    mutating func removeToy(_ toy: Toy)  {
        guard let _index = toys.firstIndex(where: { $0.id == toy.id }) else {
            print("Parent.Data: delete: child not found?")
            return
        }
        toys.remove(at: _index)
    }
    
    
    static var data:[Child] {[
        Child(id: UUID(uuidString: "14E4F450-4EF0-4B8E-AA8D-A41BE698884A")!, name: "Arne", toys: [Toy.data[0], Toy.data[1]]),
        Child(id: UUID(uuidString: "CF62A4EA-B685-44DE-BBC5-9A20A859884D")!, name: "Anita", toys: [Toy.data[1], Toy.data[2]]),
        Child(id: UUID(uuidString: "976AD892-F691-4F42-99B9-CA00605BCFD7")!, name: "Glen", toys: [Toy.data[0], Toy.data[2]])
    ]}
    
    static var zero: Child { return Child(id: UUID.zero, name: "", toys: [Toy]())}
    
    /// SF-Symbol
    static var symbol = "person"
}


