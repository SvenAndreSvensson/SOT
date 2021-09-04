//
//  ChildView.swift
//  ChildView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

struct ChildView: View {
    @EnvironmentObject var manager: SOTManager
   
    let child: Child
    
    @State private var editData: Child.Data = Child.Data()
    @State private var showEditor = false
    
    @State private var showToyEditor: Bool = false
    @State private var newToyData = Toy.Data()
    
    var body: some View {
            
            Form {
                HStack{
                    Text("Name").style(.label)
                    Text(child.name).style(.text)
                }
                
                Section {
                    ForEach(child.toys, id: \.id){toy in
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
                        editData = child.data
                        showEditor = true
                    }
                    
                    Button(action: {
                        newToyData = Toy.Data()
                        showToyEditor = true }) {
                            Image(systemName: "plus")
                        }
                }
            }
            .fullScreenCover(isPresented: $showToyEditor) {
                NavigationView {
                    ToyDataEditView(toyData: $newToyData)
                        .navigationTitle("New Toy?")
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Dismiss") {
                                    showToyEditor = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Add") {
                                    manager.append(newToyData, toToysOf: child)
                                    showToyEditor = false
                                }
                            }
                        } // toolbar
                } // NavigationView
            } // fullScreenCover
            .fullScreenCover(isPresented: $showEditor) {
                NavigationView {
                    
                    ChildDataEditView(childData: $editData)
                        .navigationTitle("Edit Child Data")
                        .toolbar {
                            
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    showEditor = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    manager.update(child, from: editData)
                                    showEditor = false
                                }
                            }
                            ToolbarItemGroup(placement: .bottomBar) {
                                Button("Delete") {
                                    manager.remove(child)
                                    showEditor = false
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
