import SwiftCrossUI
import DefaultBackend
import Subprocess

struct ContentView: View {
    @State var urlsText = ""
    @State var output = ""
    @State var isRunning = false
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.blue, style: StrokeStyle(width: 2))
                    .fill(Color.gray.opacity(0.05))
                
                TextEditor(text: $urlsText)
                    .padding(4)
                    .cornerRadius(8)
                    .frame(minHeight: 200)
            }
            
            switch isRunning {
            case true:
                ProgressView()
                    .frame(width: 100)
            case false:
                Button("Download") {
                    startDownload()
                }
                .frame(width: 100)
                .cornerRadius(5)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .fontWeight(Font.Weight.bold)
            }
    
            ZStack {
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(.black)
                
                ScrollView {
                    Text(output)
                        .foregroundColor(.green)
                }
                .background(Color.black)
                .cornerRadius(8)
                
            }.frame(minHeight: 200)
            
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
        
        Task {
            defer {
                isRunning = false
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
