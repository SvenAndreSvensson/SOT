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
    
    @State private var toyData: Toy.Data = Toy.Data()
    @State private var presentToyData = false
    
    func editToyData(){
        toyData = toy.data
        presentToyData = true
    }
    
    func updateToy(){
        manager.update(toy, from: toyData)
        presentToyData = false
    }
    
    func deletToy(){
        manager.remove(toy)
        presentToyData = false
    }
    
    var body: some View {
            
            Form {
                ListItemView(toy)
            }
            .navigationTitle("Toy")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") { editToyData() }
                }
            }
            .sheet(isPresented: $presentToyData) {
                NavigationView {
                    ToyDataEditView(toyData: $toyData)
                        .background(LinearGradient.editItemColors)
                        .navigationTitle("Edit Toy")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Cancel") { presentToyData = false }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Done") { updateToy() }
                            }
                            ToolbarItem(placement: .bottomBar) {
                                Button("Delete") { deletToy() }
                                .foregroundColor(.red)
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
