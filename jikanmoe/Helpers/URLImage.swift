//
//  URLImage.swift
//  jikanmoe
//
//  Created by Satoru Ishii on 5/7/21.
//

import SwiftUI

struct URLImage: View {

    let url: String
    @ObservedObject private var imageDownloader = ImageDownloader()

    init(url: String) {
        self.url = url
        self.imageDownloader.downloadImage(url: self.url)
    }

    var body: some View {
        if let imageData = self.imageDownloader.downloadData {
            let img = UIImage(data: imageData)
            return VStack {
                Image(uiImage: img!)
                    .resizable()
                    .frame(height: ConstantsTable.ImageSize)
                    .aspectRatio(ConstantsTable.ImageAspectRacio, contentMode: .fit)
            }
        } else {
            return VStack {
                Image(uiImage: UIImage(systemName: "icloud.and.arrow.down")!)
                    .resizable()
                    .frame(height: ConstantsTable.ImageSize)
                    .aspectRatio(ConstantsTable.ImageAspectRacio, contentMode: .fit)
            }
        }
    }
}
