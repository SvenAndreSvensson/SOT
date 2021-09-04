//
//  ChildDataEditView.swift
//  ChildDataEditView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

struct ChildDataEditView: View {

    @Binding var childData: Child.Data
    
    @State private var showToyEditor = false
    @State private var newToyData = Toy.Data()
    
    var body: some View {
        Form {
            Section{
                TextField( "Write name", text: $childData.name)
                    .style(.textField)
            }
            
            Section{
                ForEach($childData.toys){$toy in
                    NavigationLink(destination: ToyEditView(toy: $toy)
                                    .navigationTitle("Edit Toy")
                                    .toolbar(content: {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button("Delete") {
                                //showToyEditor = false
                                //let _ = childData.delete(toy)
                            }
                        }
                    })) {
                        HStack{
                            Text("Toy name")
                                .style(.label)
                            Text(toy.name)
                                .style(.text)
                        }
                    }
                }
                .onDelete { indexSet in
                    childData.toys.remove(atOffsets: indexSet)
                }
                
                HStack{
                    Spacer()
                    Button {
                        showToyEditor = true
                    } label: {
                        HStack(alignment: VerticalAlignment.firstTextBaseline, spacing: 10) {
                            Text("Add Toy")
                            Image(systemName: "plus")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(childData.name.isEmpty)
                    .padding()
                    Spacer()
                }
            } // Section
            header: { Text("Toys") }
        } // Form
        .sheet(isPresented: $showToyEditor) {
            NavigationView {
                ToyDataEditView(toyData: $newToyData)
                    .navigationBarTitle("New Toy?")
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button("Dismiss") {
                                showToyEditor = false
                            }
                        }
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button("Add") {
                                
                                let newToy = Toy(
                                    id: UUID(),
                                    name: newToyData.name)
                                
                                childData.toys.append(newToy)
                                newToyData = Toy.Data()
                                showToyEditor = false
                            }
                            .disabled(newToyData.name.isEmpty)
                        }
                    } // toolbar
            } // NavigationView
        } // sheet
    } // body
}

struct ChildDataEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ChildDataEditView(childData: .constant(Child.data[0].data))
        }
    }
}
