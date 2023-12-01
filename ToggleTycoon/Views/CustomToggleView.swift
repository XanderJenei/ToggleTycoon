import SwiftUI

struct CustomToggleView: View {
	@Binding var energy: Int
	
	@Binding var toggle: CustomToggle
	
	var body: some View {
		Toggle(isOn: $toggle.isOn) {
		}
		.toggleStyle(CustomToggleStyle(toggleTimer: $toggle.cooldownTimer,
							 toggleAble: $toggle.isAble,
							 frameWidth: toggle.width,
							 frameHeight: toggle.height,
							 activeColor: toggle.activeColor,
							 toggleText: toggle.text,
							 duration: toggle.duration,
							 cooldownOffset: toggle.cooldownOffset))
		.onChange(of: toggle.isOn) {
			customToggle(toggleState: toggle.isOn, energyAmount: toggle.energyAmount)
		}
		.disabled(!toggle.isAble)
	}
	
	func customToggle(toggleState: Bool, energyAmount: Int) {
		if(toggleState == true) {
			energy += energyAmount
		}
		UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
	}
}
