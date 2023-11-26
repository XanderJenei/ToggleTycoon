import SwiftUI

@main
struct SliderSimulatorApp: App {
      @State private var mainSlider: Bool = true
      @State private var energy: Int = 0

      var body: some Scene {
            WindowGroup {
                  ContentView(energy: $energy)
            }
      }
}
