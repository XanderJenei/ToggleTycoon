import SwiftUI

@main
struct ToggleTycoonApp: App {
      @State private var energy: Int = 0

      var body: some Scene {
            WindowGroup {
                  ToggleTycoonHomeView(energy: $energy)
            }
      }
}
