//
//  ForEachIndexed.swift
//  SOT
//
//  Created by Sven Svensson on 16/09/2021.
//

import SwiftUI

struct ForEachIndexed<Data: MutableCollection&RandomAccessCollection, RowContent: View, ID: Hashable>: View, DynamicViewContent where Data.Index : Hashable
{
    var data: [(Data.Index, Data.Element)] {
        forEach.data
    }
    
    let forEach: ForEach<[(Data.Index, Data.Element)], ID, RowContent>
    
    init(_ data: Binding<Data>,
         @ViewBuilder rowContent: @escaping (Data.Index, Binding<Data.Element>) -> RowContent
    ) where Data.Element: Identifiable, Data.Element.ID == ID {
        forEach = ForEach(
            Array(zip(data.wrappedValue.indices, data.wrappedValue)),
            id: \.1.id
        ) { i, _ in
            rowContent(i, Binding(get: { data.wrappedValue[i] }, set: { data.wrappedValue[i] = $0 }))
        }
    }
    
    init(_ data: Binding<Data>,
         id: KeyPath<Data.Element, ID>,
         @ViewBuilder rowContent: @escaping (Data.Index, Binding<Data.Element>) -> RowContent
    ) {
        forEach = ForEach(
            Array(zip(data.wrappedValue.indices, data.wrappedValue)),
            id: (\.1 as KeyPath<(Data.Index, Data.Element), Data.Element>).appending(path: id)
        ) { i, _ in
            rowContent(i, Binding(get: { data.wrappedValue[i] }, set: { data.wrappedValue[i] = $0 }))
        }
    }
    
    var body: some View {
        forEach
    }
}

struct ForEachIndexed_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        //ForEachIndexed()
    }
}

// USAGE
/*
 ForEachIndexed($todoViewModel.todos) { index, todoBinding in
     TextField("Test", text: todoBinding.title)
         .contextMenu(ContextMenu(menuItems: {
             VStack {
                 Button(action: {
                     self.todoViewModel.deleteAt(index)
                 }, label: {
                     Label("Delete", systemImage: "trash")
                 })
             }
         }))
 }
 */
