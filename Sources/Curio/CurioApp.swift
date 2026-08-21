import SwiftCrossUI
import DefaultBackend
import Subprocess

@main
struct CurioApp: App {
    @State var urlsText = ""
    @State var output = ""
    @State var isRunning = false
    
    var body: some Scene {
        WindowGroup("Curio") {
            VStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.blue, style: StrokeStyle(width: 2))
                    
                    TextEditor(text: $urlsText)
                        .padding(4)
                }
                
                Button("Download") {
                    startDownload()
                }.disabled(isRunning)
                
                ScrollView {
                    Text(output)
                        .foregroundColor(.green)
                }
                .frame(minHeight: 200)
                .background(Color.black)
                .cornerRadius(8)
                
            }.padding()
        }
        .defaultSize(width: 500, height: 500)
    }
    
    func startDownload() {
        guard !isRunning else {
            return
        }
        
        let urls = urlsText
            .split(whereSeparator: \.isNewline)
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
        
        output = ""
        isRunning = true
        
        Task {
            defer { isRunning = false }
            
            do {
                let downloader = makeDownloader()
                
                output = try await downloader.galleryDl(urls)
            } catch
            {
                output += "Failed to launcher gallery-dl: \(error)\n"
            }
        }
    }
    
    func makeDownloader() -> some Downloading {
        // TODO: Add runtime check for macOS 12 and earlier
        EasyDownloader()
    }
}
