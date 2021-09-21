//
//  ParentView.swift
//  ParentView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

struct ParentView: View {
    @EnvironmentObject var manager: SOTManager
    
    var parent: Parent
    
    @State private var presentParentData = false
    @State private var parentData = Parent.Data()
    
    @State private var presentNewChildData: Bool = false
    @State private var newChildData = Child.Data()
    
    func editParent(){
        parentData = parent.data
        presentParentData = true
    }
    
    func updateParent(){
        manager.update(parent, from: parentData)
        presentParentData = false
    }
    
    func deleteParent(){
        presentParentData = false
        manager.remove(parent)
    }
    
    func editNewChildData(){
        newChildData = Child.Data()
        presentNewChildData = true
    }
    
    func createNewChild(){
        manager.append(newChildData, toChildrenOf: parent)
        presentNewChildData = false
    }
    
    var body: some View {
        
        Form {
            
            Section {
                HStack{
                    ListItemView(parent)
                }
            }
            
            Section {
                ForEach(parent.children){child in
                    
                    NavigationLink(destination: ChildView(child: child)) {
                        ListItemView(child)
                    }.contextMenu(ContextMenu(menuItems: {
                        VStack {
                            Button(action: { manager.remove(child) }, label: {
                                Label("Delete", systemImage: "trash")
                            })
                                .foregroundColor(.red)
                        }
                    }))
                    
                } // ForEach
                .onDelete { indexSet in
                    manager.remove(atOffsets: indexSet, toChildrenOf: parent)
                }
                
                Button(action: editNewChildData ) { ListItemView.addChild() }
                
            } header: { Text("Children") }
            
        } // Form
        .navigationTitle("Parent")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                
                Button(action: editParent) {
                    Text("Edit")
                }
                Button(action: editNewChildData) {
                    Image(systemName: "plus")
                }
            }
        } // toolbar
        .sheet(isPresented: $presentNewChildData) {
            NavigationView {
                ChildDataEditView(childData: $newChildData)
                    .background(LinearGradient.newItemColors)
                    .navigationTitle("New Child")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Dismiss") { presentNewChildData = false }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Add") { createNewChild() }
                        }
                    } // toolbar
            } // NavigationView
        } // sheet
        .sheet(isPresented: $presentParentData) {
            NavigationView {
                ParentDataEditView(parentData: $parentData)
                    .background(LinearGradient.editItemColors)
                    .navigationTitle("Edit Parent Data")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") { presentParentData = false }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") { updateParent() }
                            .disabled(parentData.name.isEmpty)
                        }
                        ToolbarItem(placement: .bottomBar) {
                            Button("Delete") { deleteParent() }
                            .foregroundColor(.red)
                        }
                    } // toolbar
            } // NavigationView
        } // sheet
    } // body
} // ParentView

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ParentView(parent: Parent.data[0])
                .environmentObject(SOTManager())
            
        }
    }
}
