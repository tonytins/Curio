import SwiftCrossUI
import DefaultBackend

let cliProgram = "gallery-dl"

@main
struct CurioApp: App {
    @State var urlsText = ""
    @State var output = ""
    @State var isRunning = false
    @State var buttonColor = Color.blue
    
    var body: some Scene {
        WindowGroup("Curio") {
            ContentView()
        }
        .defaultSize(width: 500, height: 400)
    }
    
}
