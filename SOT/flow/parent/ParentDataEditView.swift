//
//  ParentDataEditView.swift
//  ParentDataEditView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

struct ParentDataEditView: View {
    
    @Binding var parentData: Parent.Data
    
    @State private var presentNewChildData = false
    @State private var newChildData = Child.Data()
    
    func editNewChildData(){
        newChildData = Child.Data()
        presentNewChildData = true
    }
    func createNewChild(){
        parentData.createChild(by: newChildData)
        presentNewChildData = false
    }
    
    func removeChild(_ child: Child){
        presentNewChildData = false
        parentData.remove(child)
    }
    
    var body: some View {
        Form {
            
            Section {
                TextField("write name", text: $parentData.name)
                    .style(.textField)
            }
            
            Section{
                ForEach($parentData.children){ $child in
                    NavigationLink(
                        destination: ChildEditView(child: $child)
                            .background(LinearGradient.editItemColors)
                            .toolbar(content: {
                                ToolbarItem(placement: .bottomBar) {
                                    Button("Delete") { removeChild(child) }
                                }
                            }))
                    {
                        ListItemView(child)
                            .contextMenu(ContextMenu(menuItems: {
                                VStack {
                                    Button(action: { parentData.remove(child) }, label: {
                                        Label("Delete", systemImage: "trash")
                                    })
                                    .foregroundColor(.red)
                                }
                            }))
                    }
                }
                .onDelete { indexSet in
                    parentData.children.remove(atOffsets: indexSet)
                }
                
                Button(action: editNewChildData ) {
                    ListItemView(symbol: "plus.circle.fill", text: "add child")
                }
                
            } // Section
            header: { Text("Children") }
        } // Form
        .sheet(isPresented: $presentNewChildData) {
            NavigationView {
                ChildDataEditView(childData: $newChildData)
                    .background(LinearGradient.newItemColors)
                    .navigationBarTitle("New Child")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Dismiss") { presentNewChildData = false }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Add") { createNewChild() }
                                .disabled(newChildData.name.isEmpty)
                        }
                    } // toolbar
            } // NavigationView
        } // sheet
    } // body
}

struct ParentDataEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ParentDataEditView(parentData: .constant(Parent.data[0].data))
        }
    }
}
