//
//  CircleImage.swift
//  study
//
//  Created by Grigory Borisov on 20.12.2023.
//

import SwiftUI


struct CircleImage: View {
    var image: Image


    var body: some View {
        image
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}


#Preview {
    CircleImage(image: Image("umbagog"))
}
