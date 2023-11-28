import SwiftUI

struct CustomToggleStyle: ToggleStyle {

      @Binding var toggleTimer: Double
      @Binding var toggleAble: Bool

      var frameWidth: CGFloat = 64
      var frameHeight: CGFloat = 32

      var activeColor: Color = .green
      var toggleText: String? = ""

      var duration: Double = 0.4
      var cooldownOffset: Double = 0.2


      func makeBody(configuration: Configuration) -> some View {
            let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

            let circleOffset = (frameWidth - frameHeight) / 2

            HStack {
                  RoundedRectangle(cornerRadius: frameHeight / 2)
				.fill(configuration.isOn ? activeColor : Color(UIColor.secondarySystemFill))
                        .overlay {
                              Circle()
                                    .fill(.white)
						.shadow(color: Color(white: 0.8, opacity: toggleAble ? 1.0 : 0.0), radius: 2, y: 1)
                                    .padding(2)

                                    .frame(width: frameHeight, height: frameHeight)
                                    .offset(x: configuration.isOn ? circleOffset : -circleOffset)
                        }
                        .frame(width: frameWidth, height: frameHeight)
                        .onTapGesture {
                              if(toggleTimer <= 0.0 + cooldownOffset){
                                    withAnimation(.spring(duration: duration, bounce: (0.25 - duration / 10))) {
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
				Text(toggleText ?? "").font(.callout).fontWeight(.thin).opacity(0.5)
                  }
            }
            .opacity(toggleAble ? 1.0 : 0.4)
      }
}
