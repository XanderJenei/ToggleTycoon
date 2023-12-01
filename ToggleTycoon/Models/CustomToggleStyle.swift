import SwiftUI

struct CustomToggleStyle: ToggleStyle {
	@Environment(\.colorScheme) var colorScheme

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

		let offsetX = configuration.isOn ? (frameWidth - frameHeight) / 2 : -(frameWidth - frameHeight) / 2
		
		let textSize = frameHeight / 2 - 2

            HStack {
			RoundedRectangle(cornerRadius: frameHeight / 2 )
				.fill(configuration.isOn ? activeColor : Color(white: colorScheme == .dark ? 0.2 : 0.8, opacity: toggleAble ? 0.6 : 1.0))
				.overlay {
					Circle()
						.fill(.white)
						.shadow(color: Color(white: colorScheme == .dark ? 0.7 : 0.3, opacity: toggleAble ? 0.5 : 0.0), radius: 2, y: 1)
						.padding(2)
						.frame(width: frameHeight, height: frameHeight)
						.offset(x: offsetX)
					if(toggleText != nil) {
						Text(toggleText ?? "")
							.font(.system(size: textSize))
							.opacity(0.5)
							.offset(x: offsetX)
							.foregroundStyle(Color(white: 0.5))
					}
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
            }
            .opacity(toggleAble ? 1.0 : 0.4)
      }
}

#Preview {
	ToggleTycoonPreviewContainer()
}
