//
//  ToyDataEditView.swift
//  ToyDataEditView
//
//  Created by Sven Svensson on 28/08/2021.
//

import SwiftUI

struct ToyDataEditView: View {
    @Binding var toyData: Toy.Data
    
    var body: some View {
        Form {
            
            TextField( "Write name", text: $toyData.name)
                .style(.textField)
            
        }
     
    } // body
}

struct ToyDataEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        ToyDataEditView(toyData: .constant(Toy.data[0].data))
        }
    }
}
