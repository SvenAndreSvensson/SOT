//
//  ParentDataEditView.swift
//  ParentDataEditView
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

struct ParentDataEditView: View {
    @Binding var parentData: Parent.Data
    
    enum Field: Hashable {
        case name
        case none
    }
    
    @State private var showChildEditor = false
    @State private var newChildData = Child.Data()
    
    var body: some View {
        Form {
            
            Section {
                TextField("write name", text: $parentData.name)
                    .style(.textField)
            }
            
            Section{
                ForEach($parentData.children){$child in
                    NavigationLink(destination: ChildEditView(child: $child)
                                    .toolbar(content: {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button("Delete") {
                                showChildEditor = false
                                let _ = parentData.delete(child)
                            }
                        }
                    })) {
                        HStack{
                            Text("Child name")
                                .style(.label)
                            Spacer()
                            Text(child.name)
                                .style(.text)
                        }
                    }
                }
                .onDelete { indexSet in
                    parentData.delete(indexSet: indexSet)
                }
                
                HStack{
                    Spacer()
                    Button {
                        newChildData = Child.Data()
                        showChildEditor = true
                    } label: {
                        HStack(alignment: VerticalAlignment.firstTextBaseline, spacing: 10) {
                            Text("Add child")
                            Image(systemName: "plus")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(parentData.name.isEmpty)
                    .padding()
                    Spacer()
                }
            }
            
        } // Form
        .sheet(isPresented: $showChildEditor) {
            NavigationView {
                ChildDataEditView(childData: $newChildData)
                    .navigationBarTitle("New Child?")
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button("Dismiss") {
                                showChildEditor = false
                            }
                        }
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button("Add") {
                                
                                let newChild = Child(
                                    id: UUID(),
                                    name: newChildData.name,
                                    toys: newChildData.toys
                                )
                                
                                parentData.children.append(newChild)
                                newChildData = Child.Data()
                                showChildEditor = false
                            }
                            .disabled(newChildData.name.isEmpty)
                        }
                    } // toolbar
            } // NavigationView
        } // sheet
    } // body
}

struct ParentDataEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        ParentDataEditView(parentData: .constant(Parent.data[0].data))
            
        }
    }
}
