//
//  ToyEditView.swift
//  ToyEditView
//
//  Created by Sven Svensson on 28/08/2021.
//

import SwiftUI

struct ToyEditView: View {
    @Binding var toy: Toy
    
    var body: some View {
        Form {
            TextField( "write name", text: $toy.name)
                .style(.textField)
        }
    } // body
}

struct ToyEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        ToyEditView(toy: .constant(Toy.data[0]))
        }
    }
}
