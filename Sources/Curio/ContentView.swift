import SwiftCrossUI
import DefaultBackend
import Subprocess

struct ContentView: View {
    @State var urlsText = ""
    @State var output = ""
    @State var isRunning = false
    @State var buttonColor = Color.blue
    
    var body: some View {
        VStack(spacing: 16) {
            TextEditor(text: $urlsText)
                .padding(4)
                .cornerRadius(8)
                .frame(minHeight: 200)
            
            Button("Download") {
                startDownload()
            }
            .frame(width: 100)
            .cornerRadius(5)
            .background(buttonColor)
            .fontWeight(Font.Weight.bold)
            .disabled(isRunning)
            
            ScrollView {
                Text(output)
                    .background(Color.black)
                    .foregroundColor(.green)
            }
            .frame(minHeight: 200)
            .cornerRadius(8)
            
        }.padding()
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
