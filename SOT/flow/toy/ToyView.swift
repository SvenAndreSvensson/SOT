//
//  ToyView.swift
//  ToyView
//
//  Created by Sven Svensson on 28/08/2021.
//

import SwiftUI

struct ToyView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var manager: SOTManager
   
    @Binding var toy: Toy
    @State var deleteFlag = false
    
    @State private var editData: Toy.Data = Toy.Data()
    @State private var showEditor = false
    
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
                        showEditor = true
                    }
                }
            }
            .fullScreenCover(isPresented: $showEditor) {
                NavigationView {
                    
                    ToyDataEditView(toyData: $editData)
                        .onDisappear(perform: {
                            /*if deleteFlag {
                                if let _pIndex = manager.parents.firstIndex(where: {$0.children.contains(child)}), let _index = manager.parents[_pIndex].children.firstIndex(of: child) {
                                    manager.parents[_pIndex].children.remove(at: _index)
                                }
                            }*/
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
                                    toy.update(from: editData)
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

struct ToyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ToyView(toy: .constant(Toy.data[0]))
        }
    }
}
