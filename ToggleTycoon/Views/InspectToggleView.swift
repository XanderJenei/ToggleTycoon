import SwiftUI

struct InspectToggleView: View {
	@Binding var toggles: [CustomToggle]

	let index: Int

	var body: some View {
		Toggle(isOn: $toggles[index].isInspecting) {
			Image(systemName: toggles[index].isInspecting ? "plus.circle.fill" : "plus.circle")
		}
		.tint(toggles[index].activeColor)
		.toggleStyle(.button)
		.clipShape(Circle())
		.opacity(toggles[index].isAble ? 1.0 : 0.5)
		.frame(width: 32, height: 16)
		.onChange(of: toggles[index].isInspecting) {
			for i in 0..<toggles.count {
				if i != index {
					toggles[i].isInspecting = false
				}
			}
		}
		.disabled(!toggles[index].isAble)
		.disabled(!toggles.allSatisfy { !$0.isInspecting || $0 == toggles[index] })
	}
}
