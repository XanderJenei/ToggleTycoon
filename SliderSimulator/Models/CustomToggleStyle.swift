import SwiftUI

struct CustomToggleStyle: ToggleStyle {

      @Binding var toggleTimer: Double
      @Binding var toggleAble: Bool

      var frameWidth: CGFloat = 64
      var frameHeight: CGFloat = 28

      var activeColor: Color = .green
      var toggleText: String? = ""

      var duration: Double = 0.4
      var cooldownOffset: Double = 0.2


      func makeBody(configuration: Configuration) -> some View {
            let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

            let circleOffset = (frameWidth - frameHeight) / 2

            HStack {
                  RoundedRectangle(cornerRadius: frameHeight / 2)
                        .fill(configuration.isOn ? activeColor : Color(UIColor.systemFill))
                        .overlay {
                              Circle()
                                    .fill(.white)
                                    .padding(2)
                                    .shadow(radius: 1)
                                    .frame(width: frameHeight, height: frameHeight)
                                    .offset(x: configuration.isOn ? circleOffset : -circleOffset)
                        }
                        .frame(width: frameWidth, height: frameHeight)
                        .onTapGesture {
                              if(toggleTimer <= 0.0 + cooldownOffset){
                                    withAnimation(.spring(duration: duration, bounce: 0.25)) {
                                          configuration.isOn.toggle()
                                          toggleTimer = duration / 2
                                    }
                              }
                        }
                        .onReceive(timer) { _ in
                              if toggleTimer > 0.0 {
                                    toggleTimer -= 0.1
                              }
                        }
                  if(toggleText != nil) {
                        Text(toggleText ?? "").font(.caption).fontWeight(.thin)
                  }
            }
            .opacity(toggleAble ? 1.0 : 0.5)
      }
}

struct CustomToggleStyle_Previews: PreviewProvider {

      struct CustomToggleStyleContainer: View {
            @State private var isOn1 = false
            @State private var isOn2 = false

            @State private var toggleTimer1 = 0.0
            @State private var toggleTimer2 = 0.0

            var body: some View {
                  VStack{
                        Toggle("Switch Me", isOn: $isOn1)
                              .toggleStyle(CustomToggleStyle(toggleTimer: $toggleTimer1, toggleAble: .constant(true)))
                        Toggle("Switch Me", isOn: $isOn2)
                              .toggleStyle(CustomToggleStyle(toggleTimer: $toggleTimer2, toggleAble: .constant(true), frameWidth: 128, activeColor: .mint, toggleText: "$2 per toggle", duration: 1.0))
                  }
            }
      }


      static var previews: some View {
            CustomToggleStyleContainer()
      }
}

