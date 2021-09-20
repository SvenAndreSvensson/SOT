//
//  ChildEditView.swift
//  ChildEditView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

struct ChildEditView: View {
    @Binding var child: Child
    
    @State private var presentNewToyData = false
    @State private var newToyData = Toy.Data()
    
    func editNewToyData(){
        newToyData = Toy.Data()
        presentNewToyData = true
    }
    func createToy(){
        child.createToy(by: newToyData)
        presentNewToyData = false
    }
    
    var body: some View {
        
        Form {
            
            Section{
                TextField( "write name", text: $child.name)
                    .style(.textField)
            }
            
            Section{
                
                ForEach($child.toys){$toy in
                    NavigationLink(destination: ToyEditView(toy: $toy)
                                    .background(LinearGradient.editItemColors)
                                    .toolbar(content: {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button(action: { child.removeToy(toy) }) {
                                ListItemView(symbol: "trash", text: "Delete")
                                
                            }
                        }
                    })) {
                        ListItemView(toy)
                    }
                    .contextMenu(ContextMenu(menuItems: {
                        VStack {
                            Button(action: { child.removeToy(toy) }, label: {
                                Label("Delete", systemImage: "trash")
                            })
                                .foregroundColor(.red)
                        }
                    }))
                }
                .onDelete { indexSet in
                    child.toys.remove(atOffsets: indexSet)
                }
                
                Button(action: editNewToyData) {
                    ListItemView(symbol: "plus.circle.fill", text: "add toy")
                }
                
            } header: { Text("Toys") } // Section
            
        } // Form
        .sheet(isPresented: $presentNewToyData, onDismiss: { print("dis") }, content: {
            NavigationView{
                ToyDataEditView(toyData: $newToyData)
                    .background(LinearGradient.newItemColors)
                    .navigationTitle("New toy")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Dismiss"){ presentNewToyData = false }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Add"){ createToy() }
                        }
                    }
            }
        })
        .navigationTitle("Edit Child")
    } // body
} 

struct ChildEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ChildEditView(child: .constant(Child.data[0]))
        }
    }
}
