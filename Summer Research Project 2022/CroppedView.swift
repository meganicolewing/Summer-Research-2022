//
//  CroppedView.swift
//  Summer Research Project 2022
//
//  Created by CTL Media Lab on 6/22/22.
//

import SwiftUI

struct CroppedView: View {
    var crop: UIImage!
    var body: some View {
        Image(uiImage: crop ?? UIImage(named: "placeholder")!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
}

struct CroppedView_Previews: PreviewProvider {
    static var previews: some View {
        CroppedView()
    }
}
