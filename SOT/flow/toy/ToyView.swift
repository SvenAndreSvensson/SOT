//
//  ToyView.swift
//  ToyView
//
//  Created by Sven Svensson on 28/08/2021.
//

import SwiftUI

struct ToyView: View {
    @EnvironmentObject var manager: SOTManager
   
    let toy: Toy
    
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
                        .toolbar {
                            
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    showEditor = false
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    manager.update(toy, from: editData)
                                    showEditor = false
                                }
                            }
                            ToolbarItemGroup(placement: .bottomBar) {
                                Button("Delete") {
                                    manager.remove(toy)
                                    showEditor = false
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
