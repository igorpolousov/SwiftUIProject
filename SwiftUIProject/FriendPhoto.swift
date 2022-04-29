//
//  FriendPhoto.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 29.04.2022.
//

import Foundation
import SwiftUI

struct FriendPhotoView: View {
    //var friendImage: UIImage
    //var friendImage = UIImage(imageLiteralResourceName: "gena")
    
    var body: some View {
        HStack {
            Image("gena")
        }
    }
}


struct FriendPhotoView_Preview: PreviewProvider {
    static var previews: some View {
        FriendPhotoView()
    }
}
