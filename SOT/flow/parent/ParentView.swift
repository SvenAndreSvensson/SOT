//
//  ParentView.swift
//  ParentView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

struct ParentView: View {
    @Binding var parent: Parent
    
    @EnvironmentObject var manager: SOTManager
    
    @State var selectedChild: Child? = nil
    
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
                            
                            NavigationLink(destination: ChildView(child: $child), tag: child , selection: $selectedChild) {
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
                                    manager.append(newChildData, toChildrenOf: parent)
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
                    
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    showEditor = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    manager.update(parent, from: editData)
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
                                            manager.remove(parent)
                                            showEditor = false
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
                .environmentObject(SOTManager())
        }
    }
}
