import SwiftUI

struct InspectToggleView: View {
	@Binding var toggles: [CustomToggle]

	let index: Int

	var body: some View {
		Button(action: {
			if(!toggles[index].isInspecting){
				toggles[index].isInspecting.toggle()
			}
		}) {
			Image(systemName: toggles[index].isInspecting ? "plus.circle.fill" : "plus.circle")
		}
		.toggleStyle(.button)
		.tint(toggles[index].activeColor)
		.clipShape(Circle())
		.opacity(toggles[index].isAble ? 1.0 : 0.0)
		.disabled(!toggles[index].isAble || !toggles.allSatisfy { !$0.isInspecting || $0 == toggles[index] })
		.padding(2)
	}
}

#Preview {
	ToggleTycoonPreviewContainer()
}
