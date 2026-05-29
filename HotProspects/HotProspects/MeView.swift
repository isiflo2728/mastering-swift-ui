//
//  MeView.swift
//  HotProspects
//
//  Created by Isidoro Flores on 5/27/26.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


struct MeView: View {
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "you@yourside.com"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    @State private var qrCode = UIImage()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)// lets users auto fill with their iphone
                    .font(.title)
                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu{
                        ShareLink(item: Image(uiImage: qrCode), preview: SharePreview("My QR Code", image: Image(uiImage: qrCode)))
                    }
     
                // swiftui tries to smooth the image out when it is scaliong but we can disable that with things like line art
                    
            }
            .navigationTitle("Your Code")
            .onAppear(perform: updateCode)
            .onChange(of: name,  updateCode)
            .onChange(of: emailAddress, updateCode)
        }
    }
    
    func generateQRCode(from string: String ) -> UIImage {
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgImage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    func updateCode(){
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
}

#Preview {
    MeView()
}
