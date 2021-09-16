//
//  ToyView.swift
//  ToyView
//
//  Created by Sven Svensson on 28/08/2021.
//

import SwiftUI

struct ToyView: View {
    @EnvironmentObject var manager: SOTManager
   
    var toy: Toy
    
    @State private var editData: Toy.Data = Toy.Data()
    //@State private var editNewToy = false
    @State private var editToy = false
    
    var body: some View {
            
            Form {
                HStack{
                    Text("Name").style(.label)
                    Text(toy.name).style(.text)
                }
            }
            .navigationTitle("Toy")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        editData = toy.data
                        editToy = true
                    }
                   /* Button {
                        editData = Toy.Data()
                        editNewToy = true
                    } label: {
                        Image(systemName: "plus")
                    }*/

                   
                }
            }
           /* .sheet(isPresented: $editNewToy, onDismiss: {}) {
                NavigationView{
                    ToyDataEditView(toyData: $editData)
                        .toolbar {
                            
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Dismiss") {
                                    editNewToy = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Add") {
                                    editNewToy = false
                                    
                                    toy =
                                    //manager.update(toy, from: editData)
                                    
                                }
                            }
                        
                        } // Toolbar
                }
            }*/
        
            .fullScreenCover(isPresented: $editToy) {
                NavigationView {
                    
                    ToyDataEditView(toyData: $editData)
                        .toolbar {
                            
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    editToy = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    manager.update(toy, from: editData)
                                    editToy = false
                                }
                            }
                            ToolbarItemGroup(placement: .bottomBar) {
                                Button("Delete") {
                                    manager.remove(toy)
                                    editToy = false
                                }
                            }
                        } // Toolbar
                } // NavigationView
            } // fullScreenCover
    } // body
} 

struct ToyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ToyView(toy: Toy.data[0])
        }
    }
}
