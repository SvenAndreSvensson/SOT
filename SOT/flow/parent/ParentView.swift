//
//  ParentView.swift
//  ParentView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

struct ParentView: View {
    var parent: Parent
    
    @EnvironmentObject var manager: SOTManager
    
    //@State var selectedChild: Child? = nil
    
    @State private var parentData = Parent.Data()
    @State private var editParent = false
    @State private var showAlert = false
    
    @State private var newChildData = Child.Data()
    @State private var editNewChild: Bool = false
    
    var body: some View {
        
            ZStack {
                Form {
                    
                    Section {
                        HStack{
                            Text("name")
                                .style(.label)
                            Spacer()
                            Text(parent.name)
                                .style(.text)
                        }
                    }
                    
                    Section {
                        ForEach(parent.children){child in
                            
                            NavigationLink(destination: ChildView(child: child)) {
                                HStack{
                                    Text("Child name")
                                        .style(.label)
                                    Text(child.name)
                                        .style(.text)
                                }
                            }
                            
                           
                        } // ForEach
                        .onDelete { indexSet in
                            manager.remove(atOffsets: indexSet, toChildrenOf: parent)                            
                        }
                        
                    
                        
                        if parent.children.count == 0 {
                            VStack{
                                Text("No children, please create a child!")
                                    .style(.text)
                                Spacer()
                            }
                        }
                        
                    } header: { Text("Children") }
                    
                } // Form
                
            } // ZStack
            .navigationTitle("Parent")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        parentData = parent.data
                        editParent = true
                        
                    } label: {
                        Text("Edit" )
                    }
                    
                    Button(action: {
                        newChildData = Child.Data()
                        editNewChild = true }) {
                            Image(systemName: "plus")
                        }
                }
            } // toolbar
            .fullScreenCover(isPresented: $editNewChild) {
                NavigationView {
                    ChildDataEditView(childData: $newChildData)
                        .navigationTitle("New Child?")
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Dismiss") {
                                    editNewChild = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Add") {
                                    manager.append(newChildData, toChildrenOf: parent)
                                    editNewChild = false
                                    
                                    /*let newChild = Child(id: UUID(), name: newChildData.name, toys: newChildData.toys)
                                    parent.children.append(newChild)
                                    editNewChild = false*/
                                    
                                }
                            }
                        } // toolbar
                } // NavigationView
            } // fullScreenCover
            .fullScreenCover(isPresented: $editParent) {
                NavigationView {
                    ParentDataEditView(parentData: $parentData)
                        .navigationTitle("Edit Parent Data")
                    
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    editParent = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    manager.update(parent, from: parentData)
                                    editParent = false
                                    //parent.update(from: parentData)
                                    
                                }.disabled(parentData.name.isEmpty)
                            }
                            ToolbarItemGroup(placement: .bottomBar) {
                                Button("Delete") {
                                    //editParent = true
                                    showAlert = true
                                }
                                .foregroundColor(.red)
                                .alert(isPresented: $showAlert, content: {
                                    Alert(
                                        // TODO: localize
                                        title: Text("Deleting"),
                                        message: Text("Deleting!"),
                                        primaryButton: .destructive(Text("Delete")) {
                                            
                                            editParent = false
                                            manager.remove(parent)
                                        },
                                        secondaryButton: .cancel()
                                    )
                                })
                            }
                        } // toolbar
                } // NavigationView
            } // fullScreenCover
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
