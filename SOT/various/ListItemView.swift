//
//  ListItemView.swift
//  SOT
//
//  Created by Sven Svensson on 16/09/2021.
//

import SwiftUI

struct ListItemView: View {
    
    var systemName: String
    let text: String
    let spacing: CGFloat = 17.0
    
    init(symbol: String, text: String){
        systemName = symbol
        self.text = text
    }
    
    init(_ child: Child){
        systemName = Child.symbol
        text = child.name
    }
    
    init(_ parent: Parent){
        systemName = Parent.symbol
        text = parent.name
    }
    
    init(_ toy: Toy){
        systemName = Toy.symbol
        text = toy.name
    }
    
    var body: some View {
        HStack(spacing: spacing){
            Image(systemName: systemName)
                .renderingMode(.original)
                .font(.system(size: 22))
            
            Text(text)
                
        }
    }
    
    static func addChild() -> ListItemView {
        return ListItemView(symbol: "plus.circle.fill", text: "add child")
    }
    static func addParent() -> ListItemView {
        return ListItemView(symbol: "person.crop.circle.badge.plus", text: "add parent")
    }
    static func addToy() -> ListItemView {
        return ListItemView(symbol: "plus.circle.fill", text: "add toy")
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(symbol: "plus.circle.fill", text: "hei")
    }
}
