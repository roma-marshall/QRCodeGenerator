//
//  QRCodeView.swift
//  QRCodeGenerator
//
//  Created by Roma Marshall on 03.03.21.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var url: String
    
    var body: some View {
        VStack {
            Image(uiImage: generateQRCodeImage(url: url))
                .interpolation(.none)
                .resizable()
                .frame(width: 150, height: 150)
        }
    }
    
    func generateQRCodeImage(url: String) -> UIImage {
        let data = Data(url.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}
