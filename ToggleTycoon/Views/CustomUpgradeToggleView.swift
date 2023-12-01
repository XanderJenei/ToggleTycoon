import SwiftUI

struct CustomUpgradeToggleView: View {
	@Binding var upgrade: Bool
	@Binding var upgradeAble: Bool

	var body: some View {
		Toggle(isOn: $upgrade) {
		}
		.toggleStyle(CustomUpgradeToggleStyle(upgradeAble: $upgradeAble))
		.onChange(of: upgrade) {
			UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
		}
		.disabled(!upgradeAble)
		.padding(4)
	}
}
