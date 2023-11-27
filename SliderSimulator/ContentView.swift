//Eventually remake this and name it "toggle tycoon"

import SwiftUI

struct ContentView: View {

      @State var showScrollView: Bool = false
      @State var scrollMaxHeight: CGFloat = 0

      @State var showText: Bool = false
      @State var energyTextOpacity: CGFloat = 0

      @Binding var energy: Int

      @State var primarySliderValue: Bool = false

      @State var secondarySliderValue: Bool = false
      @State var isSecondarySliderEnabled: Bool = false
      @State var canBuySecondarySlider: Bool = false
      @State var wouldBuySecondarySlider: Bool = true
      @State private var secondaryToggleTimer = 0.0


      @State var tertiarySliderValue: Bool = false
      @State var isTertiarySliderEnabled: Bool = false
      @State var canBuyTertiarySlider: Bool = false
      @State var wouldBuyTertiarySlider: Bool = true
      @State private var tertiaryToggleTimer = 0.0

      @State var SliderValue4: Bool = false
      @State var SliderEnabled4: Bool = false
      @State var SliderCanBuy4: Bool = false
      @State var SliderWouldBuy4: Bool = true
      @State private var ToggleTimer4 = 0.0


      var costOfSecondarySlider: Int = 15
      var costOfTertiarySlider: Int = 50
      var costOf4Slider: Int = 150


      var body: some View {
            VStack{
                  VStack {
                        Text("$" + String(energy))
                              .opacity(energyTextOpacity)
                              .font(.title)
                              .fontWeight(.bold)

                        Toggle(isOn: $primarySliderValue) {
                        }
                        .onChange(of: primarySliderValue) {
                              toggleSlider(value: primarySliderValue, energyAmount: 1, vibrate: false)
                        }
                        .labelsHidden()
                        .toggleStyle(.switch)
                  }
                  .padding()

                  ScrollView {
                        VStack {
                              VStack {
                                    HStack {
                                          Toggle(isOn: $secondarySliderValue) {
                                          }
                                          .toggleStyle(SecondaryToggleStyle(secondaryToggleTimer: $secondaryToggleTimer, MoneyPerToggleText: "$2 per toggle"))
                                          .onChange(of: secondarySliderValue) {
                                                toggleSlider(value: secondarySliderValue, energyAmount: 2, vibrate: true)
                                          }
                                          .disabled(!isSecondarySliderEnabled)
                                          .padding()

                                          Spacer()

                                          Button("$" + String(costOfSecondarySlider)) {
                                                buySlider(sliderNameCan: $isSecondarySliderEnabled, sliderNameWould: $wouldBuySecondarySlider, cost: costOfSecondarySlider)
                                          }
                                          .opacity(wouldBuySecondarySlider ? 1.0 : 0.0)
                                          .disabled(!canBuySecondarySlider)
                                          .padding()
                                    }
                              }
                              .opacity(wouldBuySecondarySlider ? ((Double(energy) / Double(costOfSecondarySlider))) : 1.0)
                              .padding()




                              VStack {
                                    HStack {
                                          Toggle(isOn: $tertiarySliderValue) {
                                          }
                                          .toggleStyle(TertiaryToggleStyle(tertiaryToggleTimer: $tertiaryToggleTimer, activeColor: .yellow, MoneyPerToggleText: "$4 per toggle"))
                                          .onChange(of: tertiarySliderValue) {
                                                toggleSlider(value: tertiarySliderValue, energyAmount: 4, vibrate: true)
                                          }
                                          .disabled(!isTertiarySliderEnabled)
                                          .padding()

                                          Spacer()

                                          Button("$" + String(costOfTertiarySlider)) {
                                                buySlider(sliderNameCan: $isTertiarySliderEnabled, sliderNameWould: $wouldBuyTertiarySlider, cost: costOfTertiarySlider)
                                          }
                                          .opacity(wouldBuyTertiarySlider ? 1.0 : 0.0)
                                          .disabled(!canBuyTertiarySlider)
                                          .padding()
                                    }
                              }
                              .opacity(wouldBuyTertiarySlider ? ((Double(energy) / Double(costOfTertiarySlider))) : 1.0)
                              .padding()


                              VStack {
                                    HStack {
                                          Toggle(isOn: $SliderValue4) {
                                          }
                                          .toggleStyle(QuaternaryToggleStyle(toggleTimer: $ToggleTimer4, activeColor: .pink, MoneyPerToggleText: "$8 per toggle"))
                                          .onChange(of: SliderValue4) {
                                                toggleSlider(value: SliderValue4, energyAmount: 8, vibrate: true)
                                          }
                                          .disabled(!SliderEnabled4)
                                          .padding()

                                          Spacer()

                                          Button("$" + String(costOf4Slider)) {
                                                buySlider(sliderNameCan: $SliderEnabled4, sliderNameWould: $SliderWouldBuy4, cost: costOf4Slider)
                                          }
                                          .opacity(SliderWouldBuy4 ? 1.0 : 0.0)
                                          .disabled(!SliderCanBuy4)
                                          .padding()
                                    }
                              }
                              .opacity(SliderWouldBuy4 ? ((Double(energy) / Double(costOf4Slider))) : 1.0)
                              .padding()
                        }
                  }
                  .frame(maxWidth: .infinity, maxHeight: scrollMaxHeight, alignment: .top)
                  .background(Material.thin)
            }
      }

      func toggleSlider(value: Bool, energyAmount: Int, vibrate: Bool) {
            if(value == true) {
                  if(vibrate) {
                        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                  }

                  energy += energyAmount
                  onEnergyChange()

            } else {
                  if(vibrate) {
                        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                  }
            }
      }

      func onEnergyChange() {
            canBuySecondarySlider = energy >= costOfSecondarySlider
            canBuyTertiarySlider = energy >= costOfTertiarySlider

            SliderCanBuy4 = energy >= costOf4Slider

            if (!showScrollView) {
                  if (energy > 1) {
                        showScrollView = true
                        withAnimation(.spring(duration: 2.0)) {
                              scrollMaxHeight = .infinity
                        }
                  }
            }

            if (!showText) {
                  withAnimation(.easeInOut(duration: 1.0)) {
                        energyTextOpacity = 1.0
                  }
                  showText = true
            }
      }

      func buySlider(sliderNameCan: Binding<Bool>, sliderNameWould: Binding<Bool>, cost: Int) {
            if (energy >= cost) {
                  energy -= cost
                  sliderNameCan.wrappedValue = true
                  sliderNameWould.wrappedValue = false
            }
      }
}

struct ContentView_Previews: PreviewProvider {

      struct ContentViewContainer: View {
            @State private var energy: Int = 150

            var body: some View {
                  ContentView(energy: $energy)
            }
      }

      static var previews: some View {
            
            ContentViewContainer()
      }
}
