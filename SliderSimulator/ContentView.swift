//Eventually remake this and name it "toggle tycoon"

import SwiftUI

struct ContentView: View {

      @Binding var energy: Int

      @State var primarySliderValue: Bool = false
      @State var secondarySliderValue: Bool = false

      @State var isSecondarySliderEnabled: Bool = false

      @State var canBuySecondarySlider: Bool = false

      var costOfSecondarySlider: Int = 15


      var body: some View {
            VStack{
                  VStack {
                        Text(energy > 0 ? (String(energy) + "⍡") : String(" "))
                              .font(.title)
                              .fontWeight(.bold)

                        Toggle(isOn: $primarySliderValue) {
                        }
                        .onChange(of: primarySliderValue) {
                              toggleSlider(value: primarySliderValue, energyAmount: 1)
                        }
                        .border(Color.green)
                        .labelsHidden()
                  }
                  .padding()
                  .border(Color.red)


                  ScrollView {
                        VStack {
                              VStack {
                                    HStack {
                                          Toggle(isOn: $secondarySliderValue) {
                                          }
                                          .toggleStyle(DefaultToggleStyle()).frame(width: 30)
                                          .onChange(of: secondarySliderValue) {
                                                toggleSlider(value: secondarySliderValue, energyAmount: 2)
                                          }
                                          .disabled(!isSecondarySliderEnabled)
                                          .padding()

                                          Spacer()

                                          Button(String(costOfSecondarySlider) + "⍡") {

                                          }
                                          .disabled(!canBuySecondarySlider)
                                          .padding()
                                    }
                              }
                              .opacity((Double(energy) / 10.0) - 0.5)
                              .border(Color.blue)
                              .padding()
                        }
                        .background(Material.regular)
                  }
                  .frame(width: .infinity, height: .infinity, alignment: .top)
            }
      }

      func toggleSlider(value: Bool, energyAmount: Int) {
            if(value == true) {
                  UIImpactFeedbackGenerator(style: .heavy).impactOccurred()

                  energy += 1
                  onEnergyChange()

            } else {
                  UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
      }

      func onEnergyChange() {
            canBuySecondarySlider = energy >= costOfSecondarySlider
      }
}

struct ContentView_Previews: PreviewProvider {

      struct ContentViewContainer: View {
            @State private var energy: Int = 14

            var body: some View {
                  ContentView(energy: $energy)
            }
      }

      static var previews: some View {
            ContentViewContainer()
      }
}
