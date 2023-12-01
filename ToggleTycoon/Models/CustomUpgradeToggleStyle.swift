import SwiftUI

struct CustomUpgradeToggleStyle: ToggleStyle {
	@Environment(\.colorScheme) var colorScheme

	@Binding var upgradeAble: Bool

	let frameWidth: CGFloat = 64
	let frameHeight: CGFloat = 32

	var activeColor: Color = .green

	let duration: Double = 0.4
	let cooldownOffset: Double = 0.2


	func makeBody(configuration: Configuration) -> some View {
		let circleOffset = (frameWidth - frameHeight) / 2

		HStack {
			RoundedRectangle(cornerRadius: frameHeight / 2)
				.fill(configuration.isOn ? activeColor : Color(white: colorScheme == .dark ? 0.2 : 0.8, opacity: upgradeAble ? 0.5 : 1.0))
				.overlay {
					Circle()
						.fill(.white)
						.shadow(color: Color(white: colorScheme == .dark ? 0.7 : 0.3, opacity: upgradeAble ? 0.5 : 0.0), radius: 2, y: 1)
						.padding(2)

						.frame(width: frameHeight, height: frameHeight)
						.offset(x: configuration.isOn ? circleOffset : -circleOffset)
				}
				.frame(width: frameWidth, height: frameHeight)
				.onTapGesture {
						withAnimation(.spring(duration: duration, bounce: (0.25 - duration / 10))) {
							configuration.isOn.toggle()

					}
				}
		}
		.opacity(upgradeAble ? 1.0 : 0.4)
	}
}
