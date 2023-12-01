import SwiftUI

struct BuyUpgradeButtonView: View {
	@Environment(\.colorScheme) var colorScheme

	@Binding var energy: Int

	@Binding var upgradeAble: Bool
	@Binding var upgradeCanAfford: Bool

	var upgradeCost: Int

	@State var finalSize: CGFloat = 0
	@State var opacity: Double = 0.0

	var body: some View {
		ZStack{
			Circle()
				.fill(.white)
				.shadow(color: Color(white: 0.8, opacity: 1.0), radius: 2, y: 1)
				.padding(2)
				.frame(width: finalSize, height: finalSize)
			
			Button("$" + upgradeCost.formatted(.number.notation(.compactName))) {
				if (energy >= upgradeCost) {
					energy -= upgradeCost
					$upgradeAble.wrappedValue = true
				}
				despawnButton()
				
				UIImpactFeedbackGenerator(style: .soft).impactOccurred()
			}
			.font(.callout)
			.fontWeight(.bold)
			.foregroundStyle(upgradeCanAfford ? Color.accentColor : Color(white: colorScheme == .dark ? 0.25 : 0.5))
			.opacity(opacity)
		}
		.disabled(!upgradeCanAfford || upgradeAble)
		.padding(2)
		.onChange(of: energy) {
			if(!upgradeAble) {
				spawnButton()
			}
			else {
				despawnButton()
			}
		}
		.onAppear(){
			if(!upgradeAble) {
				spawnButton()
			}
			else {
				despawnButton()
			}
		}
	}

	func spawnButton() {
		withAnimation(.easeOut(duration: 2.0)) {
			opacity = 1.0
		}
		withAnimation(.spring(duration: 1.0, bounce: 0.4)) {
			finalSize = 16.0 + 12.0 * Double(upgradeCost.formatted(.number.notation(.compactName)).count)
		}
	}

	func despawnButton() {
		withAnimation(.easeIn(duration: 0.1)) {
			opacity = 0.0
		}
		withAnimation(.spring(duration: 1.0, bounce: 0.25)) {
			finalSize = 0
		}
	}
}
