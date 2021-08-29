//
//  ChildView.swift
//  ChildView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

struct ChildView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var manager: SOTManager
   
    @Binding var child: Child
    @State var deleteFlag = false
    
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
                    ForEach($child.toys){$toy in
                        NavigationLink(destination: ToyView( toy: $toy)) {
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
                        child.toys.remove(atOffsets: indexSet)
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
                                    
                                    let newToy = Toy(
                                        id: UUID(),
                                        name: newToyData.name)
                                    
                                    child.toys.append(newToy)
                                    //manager.parents.append(newParent)
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
                        .onDisappear(perform: {
                            if deleteFlag {
                                if let _pIndex = manager.parents.firstIndex(where: {$0.children.contains(child)}), let _index = manager.parents[_pIndex].children.firstIndex(of: child) {
                                    manager.parents[_pIndex].children.remove(at: _index)
                                }
                            }
                        })
                        .toolbar {
                            
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    showEditor = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    //manager.update(child, of: parent, from: editData)
                                    child.update(from: editData)
                                    showEditor = false
                                }
                            }
                            ToolbarItemGroup(placement: .bottomBar) {
                                Button("Delete") {
                                    
                                    deleteFlag = true
                                    showEditor = false
                                    dismiss()
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
            ChildView(child: .constant(Child.data[0]))
                .environmentObject(SOTManager())
        }
    }
}
