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
    
    @State private var childData: Child.Data = Child.Data()
    @State private var editChild = false
    
    @State private var editNewToy: Bool = false
    @State private var newToyData = Toy.Data()
    
    func addNewToy(){
        newToyData = Toy.Data()
        editNewToy = true
    }
    
    var body: some View {
            
            Form {
                HStack{
                    Text("Name").style(.label)
                    Text(child.name).style(.text)
                }
                
                Section {
                    ForEach(child.toys){toy in
                        NavigationLink(destination: ToyView( toy: toy)) {
                            HStack{
                                Text("Toy")
                                    .style(.label)
                                Spacer()
                                Text(toy.name)
                                    .style(.text)
                            }
                        }
                    } // ForEach
                    .onDelete { indexSet in
                        manager.remove(atOffsets: indexSet, toToysOf: child)
                    }
                }
                
                if child.toys.count == 0 {
                    VStack{
                        Text("No toys, please buy a toys for your child!")
                            .style(.label)
                        Spacer()
                    }
                }
                
            } // Form
            .navigationTitle("Child")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        childData = child.data
                        editChild = true
                    }
                    
                    Button(action: addNewToy ) {
                        Image(systemName: "plus")
                    }
                }
            }
            .fullScreenCover(isPresented: $editNewToy) {
                NavigationView {
                    ToyDataEditView(toyData: $newToyData)
                        .navigationTitle("New Toy?")
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Dismiss") {
                                    editNewToy = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Add") {
                                    manager.append(newToyData, toToysOf: child)
                                    
                                    //let newToy = Toy(id: UUID(), name: childData.name)
                                    
                                    //child.toys.append(newToy)
                                    editNewToy = false
                                }
                            }
                        } // toolbar
                } // NavigationView
            } // fullScreenCover
            .fullScreenCover(isPresented: $editChild) {
                NavigationView {
                    
                    ChildDataEditView(childData: $childData)
                        .navigationTitle("Edit Child Data")
                        .toolbar {
                            
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    editChild = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    manager.update(child, from: childData)
                                    editChild = false
                                }
                            }
                            ToolbarItemGroup(placement: .bottomBar) {
                                Button("Delete") {
                                    manager.remove(child)
                                    editChild = false
                                }
                            }
                        } // Toolbar
                } // NavigationView
            } // fullScreenCover
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
