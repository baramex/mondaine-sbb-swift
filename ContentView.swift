//
//  ContentView.swift
//  mondaine-sbb
//
//  Created by Rolf Blondel on 29/09/2024.
//

import SwiftUI

struct ContentView: View {
    
    typealias AnalogClockCallback = (Date) -> Void
    
    @State private var currentTime: Date = Date.now
        
    var onUpdateTime: AnalogClockCallback? = nil
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            let sizeMultiplier: Double = geometry.size.width / 150
            
            let borderWidth: Double = 4 * sizeMultiplier
            
            let radius = geometry.size.width / 2
            let innerRadius = radius - borderWidth
            
            let tickPadding: Double = 4 * sizeMultiplier
            
            let centerX = geometry.size.width / 2
            let centerY = geometry.size.height / 2
            
            let components = Calendar.current.dateComponents([.hour, .minute, .second, .nanosecond], from: currentTime)
            
            let hour = Double(components.hour ?? 0) + Double(components.minute ?? 0) / 60
            let second = components.second ?? 0 == 0 ? 0 : components.second ?? 0 <= 1 ? Double(components.nanosecond ?? 0) / 1000000000 * 2 : Double(components.second ?? 0) + Double(components.nanosecond ?? 0) / 1000000000
            let minute = Double(components.minute ?? 0) + (second == 0 ? Double(components.nanosecond ?? 0) / 1000000000 - 1 : 0)
            
            Circle()
                .foregroundStyle(Color(red: 0.7, green: 0.7, blue: 0.7))
            
            Circle()
                .foregroundColor(.white)
                .padding(borderWidth)
            
            Path { path in
                for index in 0..<60 {
                    if(index % 5 == 0) {
                        continue
                    }
                        
                    let radian = Angle(degrees: Double(index) * 6 - 90).radians
                        
                    let lineHeight: Double = 4 * sizeMultiplier
                    
                    let x1 = centerX + (innerRadius - tickPadding) * cos(radian)
                    let y1 = centerY + (innerRadius - tickPadding) * sin(radian)
                    
                    let x2 = centerX + (innerRadius - tickPadding - lineHeight) * cos(radian)
                    let y2 = centerX + (innerRadius - tickPadding - lineHeight) * sin(radian)
                    
                    path.move(to: CGPoint(x: x1, y: y1))
                    path.addLine(to: CGPoint(x: x2, y: y2))
                }
            }
            .stroke(style: StrokeStyle(lineWidth: 2 * sizeMultiplier))
            .foregroundColor(.black)
            
            Path { path in
                for index in 0..<60 {
                    if(index % 5 != 0) {
                        continue
                    }
                        
                    let radian = Angle(degrees: Double(index) * 6 - 90).radians
                        
                    let lineHeight: Double = 12.5 * sizeMultiplier
                    
                    let x1 = centerX + (innerRadius - tickPadding) * cos(radian)
                    let y1 = centerY + (innerRadius - tickPadding) * sin(radian)
                    
                    let x2 = centerX + (innerRadius - tickPadding - lineHeight) * cos(radian)
                    let y2 = centerX + (innerRadius - tickPadding - lineHeight) * sin(radian)
                    
                    path.move(to: CGPoint(x: x1, y: y1))
                    path.addLine(to: CGPoint(x: x2, y: y2))
                }
            }
            .stroke(style: StrokeStyle(lineWidth: 4 * sizeMultiplier))
            .foregroundColor(.black)
            
            // Drawing hour hand
            Path { path in
                let height = innerRadius - tickPadding - 16.5 * sizeMultiplier
                
                let radian = Angle(degrees: hour * 30 - 90).radians
                
                let x1 = centerX - 12.5 * sizeMultiplier * cos(radian) + 3.5 * sizeMultiplier * cos(Double.pi/2 + radian)
                let y1 = centerY - 12.5 * sizeMultiplier * sin(radian) + 3.5 * sizeMultiplier * sin(Double.pi/2 + radian)
                
                let x2 = centerX - 12.5 * sizeMultiplier * cos(radian) - 3.5 * sizeMultiplier * cos(Double.pi/2 + radian)
                let y2 = centerY - 12.5 * sizeMultiplier * sin(radian) - 3.5 * sizeMultiplier * sin(Double.pi/2 + radian)
                
                let x3 = centerX + height * cos(radian) - 2.5 * sizeMultiplier * cos(Double.pi/2 + radian)
                let y3 = centerY + height * sin(radian) - 2.5 * sizeMultiplier * sin(Double.pi/2 + radian)
                
                let x4 = centerX + height * cos(radian) + 2.5 * sizeMultiplier * cos(Double.pi/2 + radian)
                let y4 = centerY + height * sin(radian) + 2.5 * sizeMultiplier * sin(Double.pi/2 + radian)
                
                path.move(to: CGPoint(x: x1, y: y1))
                path.addLine(to: CGPoint(x: x2, y: y2))
                path.addLine(to: CGPoint(x: x3, y: y3))
                path.addLine(to: CGPoint(x: x4, y: y4))
            }
            .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
            .shadow(radius: 2 * sizeMultiplier, x: 1 * sizeMultiplier, y: 1 * sizeMultiplier)
            
            // Drawing Minute hand
            Path { path in
                let height = innerRadius - tickPadding
                
                let radian = Angle(degrees: minute * 6 - 90).radians
                
                let x1 = centerX - 12.5 * sizeMultiplier * cos(radian) + 3.5 * sizeMultiplier * cos(Double.pi/2 + radian)
                let y1 = centerY - 12.5 * sizeMultiplier * sin(radian) + 3.5 * sizeMultiplier * sin(Double.pi/2 + radian)
                
                let x2 = centerX - 12.5 * sizeMultiplier * cos(radian) - 3.5 * sizeMultiplier * cos(Double.pi/2 + radian)
                let y2 = centerY - 12.5 * sizeMultiplier * sin(radian) - 3.5 * sizeMultiplier * sin(Double.pi/2 + radian)
                
                let x3 = centerX + height * cos(radian) - 2.5 * sizeMultiplier * cos(Double.pi/2 + radian)
                let y3 = centerY + height * sin(radian) - 2.5 * sizeMultiplier * sin(Double.pi/2 + radian)
                
                let x4 = centerX + height * cos(radian) + 2.5 * sizeMultiplier * cos(Double.pi/2 + radian)
                let y4 = centerY + height * sin(radian) + 2.5 * sizeMultiplier * sin(Double.pi/2 + radian)
                
                path.move(to: CGPoint(x: x1, y: y1))
                path.addLine(to: CGPoint(x: x2, y: y2))
                path.addLine(to: CGPoint(x: x3, y: y3))
                path.addLine(to: CGPoint(x: x4, y: y4))
            }
            .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
            .shadow(radius: 2 * sizeMultiplier, x: 3 * sizeMultiplier, y: 3 * sizeMultiplier)
            
            // Drawing second hand
            SecondHand(sizeMultiplier: sizeMultiplier, centerX: centerX, centerY: centerY, innerRadius: innerRadius, second: second, tickPadding: tickPadding, radius: radius)
                .shadow(radius: 2 * sizeMultiplier, x: 5 * sizeMultiplier, y: 5 * sizeMultiplier)
        }
        .frame(width: 300, height: 300)
        .aspectRatio(1, contentMode: .fit)
        .onReceive(timer) { time in
            currentTime = time
            onUpdateTime?(time)
        }
    }
}

struct SecondHand: View {
    let sizeMultiplier: Double
    let centerX: Double
    let centerY: Double
    let innerRadius: Double
    let second: Double
    let tickPadding: Double
    let radius: Double
    
    var body: some View {
        let height = innerRadius - tickPadding - 18.5 * sizeMultiplier
        
        let radian = Angle(degrees: second * 6 - 90).radians
        
        Circle()
            .position(x: centerX + (height + 2 * sizeMultiplier) * cos(radian), y: centerY + (height + 2 * sizeMultiplier) * sin(radian))
            .foregroundColor(.red)
            .frame(width: 8 * sizeMultiplier, height: 8 * sizeMultiplier)
        
        Circle()
            .foregroundColor(.red)
            .padding(radius - 2 * sizeMultiplier)
        
        Path { path in
            let x1 = centerX - 16 * sizeMultiplier * cos(radian)
            let y1 = centerY - 16 * sizeMultiplier * sin(radian)
            
            let x2 = centerX + height * cos(radian)
            let y2 = centerY + height * sin(radian)
            
            path.move(to: CGPoint(x: x1, y: y1))
            path.addLine(to: CGPoint(x: x2, y: y2))
        }
        .stroke(style: StrokeStyle(lineWidth: 1.5 * sizeMultiplier, lineCap: .round))
        .foregroundColor(.red)
    }
}

#Preview {
    ContentView()
}
