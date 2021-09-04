//
//  ChildEditView.swift
//  ChildEditView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI


struct ChildEditView: View {
    @Binding var child: Child
    
    @State private var showToyEditor = false
    @State private var newToyData = Toy.Data()
    
    var body: some View {
        Form {
            
            Section{
            TextField( "write name", text: $child.name)
                .style(.textField)
            }
            
            Section{
                ForEach($child.toys){$toy in
                    NavigationLink(destination: ToyEditView(toy: $toy)
                                    .toolbar(content: {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button("Delete") {
                                //showToyEditor = false
                                
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
                    child.toys.remove(atOffsets: indexSet)
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
                    .disabled(child.name.isEmpty)
                    .padding()
                    Spacer()
                }
            }
            
        }
        .navigationTitle("Edit Child")
    } // body
} 

struct ChildEditView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView{
        ChildEditView(child: .constant(Child.data[0]))
        }
    }
}
