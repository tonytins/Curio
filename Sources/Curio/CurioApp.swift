import DefaultBackend
import SwiftCrossUI

let cliProgram = "gallery-dl"

@main
@HotReloadable
struct CurioApp: App {
    var body: some Scene {
        WindowGroup("Curio") {
            #hotReloadable {
                ContentView()
            }
        }
        .defaultSize(width: 500, height: 400)
    }
}
