//
//  ContentView.swift
//  TextOnFonChanged
//
//  Created by Nikolay Nikolayenko on 02/12/2021.
//

import SwiftUI

struct ContentView: View {
    var text = "12:34"
    @State var colorR: Double = 125.0
    @State var colorG: Double = 125.0
    @State var colorB: Double = 125.0
   // @State var colorOfText: Color = Color.white
    var body: some View {
        VStack {
            VStack {
                Text(text)
                    .font(.system(size: 100))
                
                    .foregroundColor(isColorIsDark() ? Color.white : Color.black)
                    .animation(.easeInOut(duration: 1.0))
                .padding()
            }
            .onTapGesture {
            withAnimation(.easeInOut(duration: 1.0)) {
                self.colorR = 125.0
                self.colorG = 125.0
                self.colorB = 125.0
            }
            
            }
            
            Spacer()
            // create 3 sliders for RGB
            VStack {
                Text("Red")
                Slider(value: $colorR, in: 0...255, step: 1)
                
                Text("Green")
                Slider(value: $colorG, in: 0...255, step: 1)
                
                Text("Blue")
                Slider(value: $colorB, in: 0...255, step: 1)
            }
        }
        .background(setColor())
        
        
        
    }
    func setColor() -> Color {
        let color = Color(red: colorR/255, green: colorG/255, blue: colorB/255)
        return color
    }
    
    func isColorIsDark() -> Bool {
        let color = Color(red: colorR/255, green: colorG/255, blue: colorB/255)
        // convert to HSB
        let hsb = convertRGBToHSB(red: colorR, green: colorG, blue: colorB)
        // check if brightness is dark
        return hsb.brightness < 0.5
    }
    
    func convertRGBToHSB(red: Double, green: Double, blue: Double) -> (hue: Double, saturation: Double, brightness: Double) {
        let r = red/255
        let g = green/255
        let b = blue/255
        let max = max(r, max(g, b))
        let min = min(r, min(g, b))
        let delta = max - min
        var hue: Double = 0
        var saturation: Double = 0
        var brightness: Double = 0
        if max != 0 {
            saturation = delta / max
            if r == max {
                hue = (g - b) / delta
            } else if g == max {
                hue = 2 + (b - r) / delta
            } else {
                hue = 4 + (r - g) / delta
            }
            hue *= 60
            if hue < 0 {
                hue += 360
            }
        }
        brightness = max
        return (hue, saturation, brightness)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
