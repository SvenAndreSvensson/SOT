//
//  SOTView.swift
//  SOTView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

struct SOTView: View {
    @EnvironmentObject var manager: SOTManager
    
    @State private var editNewParent: Bool = false
    @State private var newParentData = Parent.Data()
    
   
    
    
    var body: some View {
        NavigationView {
            ZStack{
                List{
                    /*
                    ForEachIndexed($manager.parents) { index, parent in
                        Text(parent.wrappedValue.name)
                            .contextMenu(ContextMenu(menuItems: {
                                VStack {
                                    Button(action: {
                                        manager.remove(at: index)
                                        //self.todoViewModel.deleteAt(index)
                                    }, label: {
                                        Label("Delete", systemImage: "trash")
                                    })
                                }
                            }))
                    }*/
                    
                    
                    
                    ForEach(manager.parents){parent in
                        
                        NavigationLink(destination: ParentView(parent: parent)) {
                            HStack{
                                Text("Parent")
                                    .style(.label)
                                Text(parent.name)
                                    .style(.text)
                            }
                        }
                        .contextMenu(ContextMenu(menuItems: {
                            VStack {
                                Button(action: {
                                    manager.remove(parent)
                                    
                                }, label: {
                                    Label("Delete", systemImage: "trash")
                                })
                            }
                        }))
                        
                        
                    }
                    .onDelete { indexSet in
                        manager.remove(atOffsets: indexSet)
                    }
                } // List
                
                if manager.parents.count == 0 {
                    VStack{
                        Text("Add parent with the +")
                        Spacer()
                    }
                }
                
            } // ZStack
            .navigationTitle("Parents")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        newParentData = Parent.Data()
                        editNewParent = true }) {
                            Image(systemName: "plus")
                        }
                }
            } // toolbar
            .fullScreenCover(isPresented: $editNewParent) {
                NavigationView {
                    ParentDataEditView(parentData: $newParentData)
                        .navigationTitle("New Parent?")
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Dismiss") {
                                    editNewParent = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Add") {
                                    manager.append(newParentData)
                                    editNewParent = false
                                    /*
                                    let newParent = Parent(id: UUID(), name: newParentData.name, children: newParentData.children)
                                    
                                     editNewParent = false
                                    manager.parents.append(newParent)
                                    */
                                    
                                    
                                }
                                .disabled(newParentData.name.isEmpty)
                            }
                        } // toolbar
                } // NavigationView
            } // fullScreenCover
        } // NavigationView
    } // body
}

struct SOTView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SOTView()
                .previewDisplayName("EmptyState")
                .environmentObject(SOTManager.emptyState)
            
            SOTView()
                .previewDisplayName("FullState")
                .environmentObject(SOTManager.fullState)
        }
    }
}
