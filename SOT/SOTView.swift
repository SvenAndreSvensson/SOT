//
//  SOTView.swift
//  SOTView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

struct SOTView: View {
    @EnvironmentObject var manager: SOTManager
    
    @State private var presentNewParentData: Bool = false
    @State private var newParentData = Parent.Data()
    
    func editNewParentData(){
        newParentData = Parent.Data()
        presentNewParentData = true
    }
    
    func createParent(){
        manager.append(newParentData)
        presentNewParentData = false
    }
    
    var body: some View {
        NavigationView {
            
            List{
                
                ForEach(manager.parents){parent in
                    
                    NavigationLink(destination: ParentView(parent: parent)) {
                        ListItemView(parent)
                    }
                    .contextMenu(ContextMenu(menuItems: {
                        VStack {
                            Button(action: { manager.remove(parent) }, label: {
                                Label("Delete", systemImage: "trash")
                            })
                        }
                    }))
                    
                } // ForEach
                .onDelete { indexSet in
                    manager.remove(atOffsets: indexSet)
                }
                
                Button(action: editNewParentData) {
                    ListItemView(symbol: "plus.circle.fill", text: "add parent")
                }
                
            } // List
            
            .navigationTitle("Parents")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: editNewParentData) {
                        Image(systemName: "plus")
                    }
                }
            } // toolbar
            .sheet(isPresented: $presentNewParentData) {
                NavigationView {
                    ParentDataEditView(parentData: $newParentData)
                        .background(LinearGradient.newItemColors)
                        .navigationTitle("New Parent")
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Dismiss") { presentNewParentData = false }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Add") { createParent() }
                                    .disabled(newParentData.name.isEmpty)
                            }
                        } // toolbar
                } // NavigationView
            } // sheet
        } // NavigationView
    } // body
}

struct SOTView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SOTView()
                .previewDisplayName("EmptyState")
                .environmentObject(SOTManager.emptyState)
                .preferredColorScheme(.dark)
            
            SOTView()
                .previewDisplayName("FullState")
                .environmentObject(SOTManager.fullState)
                .preferredColorScheme(.light)
        }
    }
}
