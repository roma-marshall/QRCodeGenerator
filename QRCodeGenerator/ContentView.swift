//
//  ContentView.swift
//  QRCodeGenerator
//
//  Created by Roma Marshall on 03.03.21.
//

import SwiftUI

struct ContentView: View {
    @State var url: String = ""
    
    var body: some View {
        VStack {
            Text("Hello, world!")
            
            Image(uiImage: QRCodeView(url: url).generateQRCodeImage(url: url))
                .interpolation(.none)
                .resizable()
                .frame(width: 150, height: 150)
            
            TextField("Your URL", text: $url)
                .multilineTextAlignment(.center)
                .font(.title2)
                .padding()
                            
            ShareView(url: self.$url)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ShareView: View {
    @State var items: [Any] = []
    @State var sheet = false
    @Binding var url: String
        
    var body: some View {
        VStack {
            Button(action: {
                // adding items to be shared
                items.removeAll()
                items.append(QRCodeView(url: url).generateQRCodeImage(url: url))
                sheet.toggle()
            }) {
                Image(systemName: "square.and.arrow.up")
                    .font(.largeTitle)
            }
        }
        .sheet(isPresented: $sheet, content: {
            ShareSheet(items: items)
        })
    }
}

// share Sheet
struct ShareSheet: UIViewControllerRepresentable {
    
    // the data you need to share
    var items: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}

