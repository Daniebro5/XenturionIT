import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {

  @AppStorage("name") private var name = "Anonymus"
  @AppStorage("emailAddress") private var emailAddress = "micorreo@servidor.com"

  @State private var qrCode = UIImage()

  let context = CIContext()
  let filter = CIFilter.qrCodeGenerator()

  var body: some View {
    NavigationStack {
      Form {
        TextField("Nombre", text: $name)
          .textContentType(.name)
          .font(.title)

        TextField("Correo Electronico", text: $emailAddress)
          .textContentType(.emailAddress)
          .font(.title)

        Image(uiImage: qrCode)
          .interpolation(.none)
          .resizable()
          .scaledToFit()
          .frame(width: 200, height: 200)
          .contextMenu {
            ShareLink(item: Image(uiImage: qrCode),
                      preview: SharePreview("My QR Code",
                                            image: Image(uiImage: qrCode)))
          }
      }
      .navigationTitle("Tu Codigo QR")
      .onAppear(perform: updateQRCode)
      .onChange(of: name, updateQRCode)
      .onChange(of: emailAddress, updateQRCode)
    }
  }

  func generateQRCode(from string: String) -> UIImage {
    filter.message = Data(string.utf8)

    if let outputImage = filter.outputImage {
      if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
        return UIImage(cgImage: cgImage)
      }
    }

    return UIImage(systemName: "xmark.circle") ?? UIImage()
  }

  func updateQRCode() {
    qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
  }
}

#Preview {
  MeView()
}
