import SwiftUI

struct InspectToggleStyle: ToggleStyle {
      @Binding var toggleAble: Bool

      var activeColor: Color = .primary

      func makeBody(configuration: Configuration) -> some View {

            HStack {
                  Label("Inspect", systemImage: "plus.circle")
                        .labelStyle(.iconOnly)
                        .frame(width: 100, height: 100)
            }
            .opacity(toggleAble ? 1.0 : 0.0)
      }
}

struct InspectToggleStyle_Previews: PreviewProvider {

      struct InspectToggleStyleContainer: View {
            @State private var isOn = false

            @State private var toggleAble = true

            var body: some View {
                  VStack{
                        Toggle("Inspect", isOn: $isOn)
                              .toggleStyle(InspectToggleStyle(toggleAble: $toggleAble))
                  }
            }
      }


      static var previews: some View {
            InspectToggleStyleContainer()
      }
}

