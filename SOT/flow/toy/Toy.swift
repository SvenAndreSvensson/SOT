//
//  Toy.swift
//  Toy
//
//  Created by Sven Svensson on 28/08/2021.
//

import Foundation

struct Toy: Identifiable, Equatable {
    var id: UUID
    var name: String
}

extension Toy {
    struct Data {
        var name: String = ""
    }
    
    var data: Data { return Data(name: name)}
    
    mutating func update(from data: Toy.Data) {
        self.name = data.name
    }
    
    static var data:[Toy] {[
        Toy(id: UUID(uuidString: "C7EEEE90-77A2-4590-8A81-054298178DA3")!, name: "Toy one"),
        Toy(id: UUID(uuidString: "5358A934-9AD5-4CF7-9AED-944FC1E95C4B")!, name: "Toy two"),
        Toy(id: UUID(uuidString: "71A202C5-DA07-44F1-81EA-E028A09D8567")!, name: "Toy three"),
    ]}
    
    static var zero: Toy { return Toy(id: UUID.zero, name: "")}
}


