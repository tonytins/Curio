import DefaultBackend
import Subprocess
import SwiftCrossUI

struct ContentView: View {
  @State var urlsText = ""
  @State var output = ""
  @State var isRunning = false
  @State var isLoading = false
  @State var version = ""

  var body: some View {
    VStack(spacing: 16) {
      // Input box
      ZStack {
        RoundedRectangle(cornerRadius: 8)
          .stroke(.blue, style: StrokeStyle(width: 2))
          .fill(Color.gray.opacity(0.05))

        TextEditor(text: $urlsText)
          .padding(4)
          .cornerRadius(8)
          .frame(minHeight: 200)
          .help("One address per line")
      }

      Button("Download") {
        Task {
          await startDownload()
        }
      }
      .frame(width: 100)
      .cornerRadius(5)
      .background(Color.blue)
      .foregroundColor(Color.white)
      .fontWeight(Font.Weight.bold)
      .disabled(isRunning)

      // Output panel
      ZStack {
        RoundedRectangle(cornerRadius: 8)
          .fill(.black)

        ScrollView {
          Text(output)
            .foregroundColor(.green)
        }
        .background(Color.black)
        .cornerRadius(8)

      }.overlay(alignment: .bottomTrailing) {
        if isRunning || isLoading {
          ProgressView()
            .padding(10)
        }
      }
      .frame(minHeight: 100)

      ZStack {
        if !version.isEmpty {
          Text("gallery-dl \(version)")
            .frame(alignment: .bottomLeading)
        }
      }
      .onAppear {
        Task {
          await getVersion()
        }
      }
      .frame(minHeight: 15)

    }.frame(minWidth: 500, idealWidth: 400)
      .padding()
  }

  func getVersion() async {
    let downloader = makeDownloader()

    guard !isLoading else {
      return
    }

    isLoading = true

    defer {
      isLoading = false
    }

    do {
      version = try await downloader.galleryDl(["--version"])
    } catch {}
  }

  func startDownload() async {
    guard !isRunning else {
      return
    }

    let urls =
      urlsText
      .split(whereSeparator: \.isNewline)
      .map { $0.trimmingCharacters(in: .whitespaces) }
      .filter { !$0.isEmpty }

    output = ""
    isRunning = true

    defer {
      isRunning = false
    }

    do {
      let downloader = makeDownloader()

      output = try await downloader.galleryDl(urls)
    } catch {
      output += "\(error)"
    }
  }

  func makeDownloader() -> some Downloading {
    // TODO: Add runtime check for macOS 12 and earlier
    EasyDownloader()
  }
}
