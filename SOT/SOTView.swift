//
//  SOTView.swift
//  SOTView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

struct SOTView: View {
    @EnvironmentObject var manager: SOTManager
    
    @State private var showEditor: Bool = false
    @State private var newData = Parent.Data()
    
    
    
    var body: some View {
        NavigationView {
            ZStack{
                List{
                    ForEach(manager.parents, id: \.id){parent in
                        
                        
                        NavigationLink(destination: ParentView(parent: parent)) {
                            HStack{
                                Text("Parent")
                                    .style(.label)
                                Spacer()
                                Text(parent.name)
                                    .style(.text)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        manager.remove(atOffsets: indexSet)
                    }
                } // List
                
                if manager.parents.count == 0 {
                    VStack{
                        Text("No Parents, please add Parent!")
                        Spacer()
                    }
                }
                
            } // ZStack
            .navigationTitle("Parents")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        newData = Parent.Data()
                        showEditor = true }) {
                            Image(systemName: "plus")
                        }
                }
            } // toolbar
            .fullScreenCover(isPresented: $showEditor) {
                NavigationView {
                    ParentDataEditView(parentData: $newData)
                        .navigationTitle("New Parent?")
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Dismiss") {
                                    showEditor = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Add") {
                                    
                                    manager.append(newData)
                                    showEditor = false
                                    
                                }
                                .disabled(newData.name.isEmpty)
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
