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
    }
}
