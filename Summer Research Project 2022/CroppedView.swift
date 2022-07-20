//
//  CroppedView.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 6/22/22.
//

import SwiftUI

struct CroppedView: View {
    var testResults: results!
    var body: some View {
        VStack{
            Text("Test One Left: \(testResults.test1Left)")
            Text("Text One Right: \(testResults.test1Right)")
            Text("Test Two Left: \(testResults.test2Left)")
            Text("Text Two Right: \(testResults.test2Right)")
            Text("Test Three Left: \(testResults.test3Left)")
            Text("Text Three Right: \(testResults.test3Right)")
        }
    }
}

struct CroppedView_Previews: PreviewProvider {
    static var previews: some View {
        CroppedView()
    }
}
