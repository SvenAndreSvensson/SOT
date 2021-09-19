//
//  ChildView.swift
//  ChildView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

struct ChildView: View {
    @EnvironmentObject var manager: SOTManager
   
    var child: Child
    
    @State private var presentChildData = false
    @State private var childData: Child.Data = Child.Data()
    
    @State private var presentNewToyData: Bool = false
    @State private var newToyData = Toy.Data()
    
    
    func editChildData(){
        childData = child.data
        presentChildData = true
    }
    
    func updateChild(){
        manager.update(child, from: childData)
        presentChildData = false
    }
    
    func deleteChild(){
        manager.remove(child)
        presentChildData = false
    }
    
    func editNewToyData(){
        newToyData = Toy.Data()
        presentNewToyData = true
    }
    
    func createNewToy(){
        manager.append(newToyData, toToysOf: child)
        presentNewToyData = false
    }
    
    var body: some View {
            
            Form {
                
                ListItemView(child)
                
                Section {
                    ForEach(child.toys){ toy in
                        NavigationLink(destination: ToyView( toy: toy)) {
                            ListItemView(toy)
                        }
                        .contextMenu(ContextMenu(menuItems: {
                            VStack {
                                Button(action: { manager.remove(toy) }, label: {
                                    Label("Delete", systemImage: "trash")
                                })
                                .foregroundColor(.red)
                            }
                        }))
                        
                    } // ForEach
                    
                    .onDelete { indexSet in
                        manager.remove(atOffsets: indexSet, toToysOf: child)
                    }
                    
                    Button(action: editNewToyData) {
                        ListItemView.addToy()
                    }
                } header: { Text("Toys") }
                
            } // Form
            .navigationTitle("Child")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: editChildData) { Text("Edit") }
                    Button(action: editNewToyData ) { Image(systemName: "plus") }
                }
            }
            .sheet(isPresented: $presentNewToyData) {
                NavigationView {
                    ToyDataEditView(toyData: $newToyData)
                        .background(LinearGradient.newItemColors)
                        .navigationTitle("New Toy")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Dismiss") { presentNewToyData = false }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Add") { createNewToy() }
                            }
                        } // toolbar
                } // NavigationView
            } // sheet
            .sheet(isPresented: $presentChildData) {
                NavigationView {
                    ChildDataEditView(childData: $childData)
                        .background(LinearGradient.editItemColors)
                        .navigationTitle("Edit Child Data")
                        .toolbar {
                            
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Cancel") { presentChildData = false }
                            }
                            ToolbarItem(placement: .navigationBarTrailing){
                                Button("Done") { updateChild() }
                            }
                            ToolbarItem(placement: .bottomBar) {
                                Button("Delete") { deleteChild() }
                                .foregroundColor(.red)
                            }
                        } // toolbar
                } // NavigationView
            } // sheet
    } // body
} 

struct ChildView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ChildView(child: Child.data[0])
                .environmentObject(SOTManager())
        }
    }
}
