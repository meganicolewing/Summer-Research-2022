//
//  ErrorView.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 7/26/22.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        Text("There was an error processing your test. Please take a new picture and try again.")
            .padding()
            .navigationBarTitle("Oops... Something Went Wrong")
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
