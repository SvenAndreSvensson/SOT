//
//  ChildDataEditView.swift
//  ChildDataEditView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

struct ChildDataEditView: View {

    @Binding var childData: Child.Data
    
    @State private var presentToyData = false
    @State private var toyData = Toy.Data()
    
    func editToyData(){
        toyData = Toy.Data()
        presentToyData = true
    }
    
    func createToy(){
        childData.createToy(by: toyData)
        presentToyData = false
    }
    
    func deleteToy(_ toy: Toy){
        presentToyData = false
        childData.deleteToy(toy)
    }
    
    var body: some View {
        Form {
            Section{
                TextField( "Write name", text: $childData.name)
                    .style(.textField)
            }
            
            Section{
                ForEach($childData.toys){$toy in
                    NavigationLink(destination:
                                    ToyEditView(toy: $toy)
                                    .background(LinearGradient.editItemColors)
                                    .navigationTitle("Edit Toy")
                                    .toolbar(content:
                                                {
                        ToolbarItem(placement: .bottomBar) {
                            
                            Button(action: { deleteToy(toy) }) {
                                Text("Delete")
                            }
                            .foregroundColor(.red)
                        }
                    })) {
                        ListItemView(toy)
                    }
                    .contextMenu(ContextMenu(menuItems: {
                        VStack {
                            Button(action: { deleteToy(toy) }, label: {
                                Label("Delete", systemImage: "trash")
                            })
                            .foregroundColor(.red)
                        }
                    }))
                }
                .onDelete { indexSet in
                    childData.toys.remove(atOffsets: indexSet)
                }
                
                Button(action: editToyData) {
                    ListItemView.addToy()
                }
                
                
            } // Section
            header: { Text("Toys") }
        } // Form
        .sheet(isPresented: $presentToyData) {
            NavigationView {
                ToyDataEditView(toyData: $toyData)
                    .background(LinearGradient.newItemColors)
                    .navigationBarTitle("New Toy")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: { presentToyData = false }, label: { Text("Dismiss") })
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: createToy, label: { Text("Add") })
                        }
                    } // toolbar
            } // NavigationView
        } // sheet
    } // body
}

struct ChildDataEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ChildDataEditView(childData: .constant(Child.data[0].data))
        }
    }
}
