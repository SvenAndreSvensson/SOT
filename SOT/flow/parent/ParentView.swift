//
//  ParentView.swift
//  ParentView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

struct ParentView: View {
    @Binding var parent: Parent
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var manager: SOTManager
    
    @State private var deleteFlag: Bool = false
    
    @State private var showEditor = false
    @State private var editData = Parent.Data()
    @State private var showAlert = false
    
    @State private var showChildEditor: Bool = false
    @State private var newChildData = Child.Data()
    
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
                        ForEach($parent.children){$child in
                            NavigationLink(destination: ChildView( child: $child)) {
                                HStack{
                                    Text("Child")
                                        .style(.label)
                                    Spacer()
                                    Text(child.name)
                                        .style(.text)
                                }
                            }
                        } // ForEach
                        .onDelete { indexSet in
                            parent.children.remove(atOffsets: indexSet)
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
                        editData = parent.data
                        showEditor = true
                        
                    } label: {
                        Text("Edit" )
                    }
                    
                    Button(action: {
                        newChildData = Child.Data()
                        showChildEditor = true }) {
                            Image(systemName: "plus")
                        }
                }
            } // toolbar
            .fullScreenCover(isPresented: $showChildEditor) {
                NavigationView {
                    ChildDataEditView(childData: $newChildData)
                        .navigationTitle("New Child?")
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Dismiss") {
                                    showChildEditor = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Add") {
                                    
                                    let newChild = Child(
                                        id: UUID(),
                                        name: newChildData.name,
                                        toys: newChildData.toys)
                                    
                                    parent.children.append(newChild)
                                    //manager.parents.append(newParent)
                                    showChildEditor = false
                                    
                                }
                                
                            }
                        } // toolbar
                } // NavigationView
            } // fullScreenCover
            .fullScreenCover(isPresented: $showEditor) {
                NavigationView {
                    ParentDataEditView(parentData: $editData)
                        .navigationTitle("Edit Parent Data")
                        .onDisappear(perform: {
                            print("ParentView: .onDisappear")
                            if deleteFlag {
                                if let index = manager.parents.firstIndex(of: parent) {
                                    manager.parents.remove(at: index)
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
                                    parent.update(from: editData)
                                    showEditor = false
                                }.disabled(editData.name.isEmpty)
                            }
                            ToolbarItemGroup(placement: .bottomBar) {
                                Button("Delete") {
                                    showAlert = true
                                }
                                .foregroundColor(.red)
                                .alert(isPresented: $showAlert, content: {
                                    Alert(
                                        // TODO: localize
                                        title: Text("Deleting"),
                                        message: Text("Deleting!"),
                                        primaryButton: .destructive(Text("Delete")) {
                                            
                                            deleteFlag = true
                                            showEditor = false
                                            dismiss()
                    
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
        ParentView(parent: .constant(Parent.data[0]))
        }
    }
}
