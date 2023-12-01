import SwiftUI

struct BuyButtonView: View {
	@Binding var energy: Int
	@Binding var toggle: CustomToggle

	@State var finalSize: CGFloat = 0
	@State var opacity: Double = 0.0

	var body: some View {
		ZStack{
			Circle()
				.fill(.white)
				.shadow(color: Color(white: 0.8, opacity: 1.0), radius: 2, y: 1)
				.padding(2)
				.frame(width: finalSize, height: finalSize)

			Button("$" + toggle.cost.formatted(.number.notation(.compactName))) {
				buySlider(toggleAbility: $toggle.isAble, cost: toggle.cost)

				despawnButton()

				UIImpactFeedbackGenerator(style: .soft).impactOccurred()
			}
			.font(.callout)
			.fontWeight(.bold)
			.foregroundStyle(toggle.canAfford ? Color.accentColor : Color.gray)
			.opacity(opacity)
		}
		.disabled(!toggle.canAfford || toggle.isAble)
		.padding(2)

		.onChange(of: toggle.showBuyButton) {
			if (toggle.showBuyButton) {
				spawnButton()
			} else {
				despawnButton()
			}
		}
		.onChange(of: energy) {
			if(!toggle.isAble) {
				if (energy * 2 >= toggle.cost / 2) {
					toggle.showBuyButton = true
				} else {
					toggle.showBuyButton = false
				}
			}
		}
	}

	func spawnButton() {
		withAnimation(.easeIn(duration: 1.0)) {
			opacity = 1.0
		}
		withAnimation(.spring(duration: 1.0, bounce: 0.5)) {
			finalSize = 16.0 + 12.0 * Double(toggle.cost.formatted(.number.notation(.compactName)).count)
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

      func buySlider(toggleAbility: Binding<Bool>, cost: Int) {
            if (energy >= cost) {
                  energy -= cost
                  toggleAbility.wrappedValue = true
            }
      }
}
