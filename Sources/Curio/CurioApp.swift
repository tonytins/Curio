import SwiftCrossUI
import DefaultBackend
import Subprocess

let cliProgram = "gallery-dl"

@main
struct CurioApp: App {
    @State var urlsText = ""
    @State var output = ""
    @State var isRunning = false
    @State var buttonColor = Color.blue
    
    var body: some Scene {
        WindowGroup("Curio") {
            VStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.blue, style: StrokeStyle(width: 2))
                    
                    TextEditor(text: $urlsText)
                        .padding(4)
                }
                
                HStack {
                    Button("Download") {
                        startDownload()
                    }
                    .frame(width: 100)
                    .background(buttonColor)
                    .fontWeight(Font.Weight.bold)
                    .disabled(isRunning)
                    
                }
                
                ScrollView {
                    Text(output)
                        .background(Color.black)
                        .foregroundColor(.green)
                }
                .frame(minHeight: 200)
                .cornerRadius(8)
                
            }.padding()
        }
        .defaultSize(width: 500, height: 300)
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
        buttonColor = Color.gray
        
        Task {
            defer {
                isRunning = false
                buttonColor = Color.blue
            }
            
            do {
                
                let downloader = makeDownloader()
                
                output = try await downloader.galleryDl(urls)
            } catch
            {
                output += "\(error)"
            }
        }
    }
    
    func makeDownloader() -> some Downloading {
        // TODO: Add runtime check for macOS 12 and earlier
        EasyDownloader()
    }
}
