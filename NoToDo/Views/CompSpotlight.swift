//
//  CompSpotlight.swift
//  NoToDo
//
//  Created by Kodgem Technology on 23.01.2024.
//

import SwiftUI

struct CompSpotlight: View {
    @State var showSpotlight:Bool = false
    @State var currentSpot:Int = 0
    var body: some View {
        ZStack {
            
            VStack {
                Text("Furkan")
                Text("Furkan")
                Text("Furkan")
                Text("Furkan")
                Text("Furkan")
            }
            
            ZStack {
                Color.red
                    .edgesIgnoringSafeArea(.all)
                    .mask {
                        Rectangle().frame(width: 100, height: 100)
                            .overlay {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .blendMode(.destinationOut)
                            }
                    }
                    .addSpotlight(0, shape: .rounded, roundedRadius: 10, text: Text("Furkan"))
 
            }
        }
        .addSpotlightOverlay(show: $showSpotlight, currentSpot: $currentSpot)
        .onAppear(){
            showSpotlight = true
        }
    }
}

#Preview {
    CompSpotlight()
}


extension View{
    @ViewBuilder
    func addSpotlight(_ id:Int, shape: SpotlightShape = .rectangle, roundedRadius: CGFloat = 0, text:Text = Text(""), placeholderAlignment:SpotlightAlignment = .bottom)-> some View{
        self
            .anchorPreference(key: BoundsKey.self, value: .bounds){[id: BoundsKeyProperties(shape: shape, anchor: $0, text: text, radius: roundedRadius, placeholderAlignment: placeholderAlignment)]}
    }
    
    
    @ViewBuilder
    func addSpotlightOverlay(show: Binding<Bool>,currentSpot: Binding<Int>)-> some View{
        self
            .overlayPreferenceValue(BoundsKey.self){ values in
                
                GeometryReader{ proxy in
                    if let preference = values.first(where: { item in
                        item.key == currentSpot.wrappedValue
                    }){
                        let screenSize = proxy.size
                        let anchor = proxy[preference.value.anchor]
                        
                        SpotlightHelperView(screenSize: screenSize, rect: anchor,show: show, currentSpot: currentSpot, properties: preference.value){
                            if currentSpot.wrappedValue <= (values.count){
                                currentSpot.wrappedValue += 1
                            }
                            else{
                                show.wrappedValue = false
                            }
                        }
                    }
                    
                }
                .ignoresSafeArea()
                .animation(.default, value: show.wrappedValue)
                .animation(.default, value: currentSpot.wrappedValue)

            }
    }
    
    @ViewBuilder
    func SpotlightHelperView(screenSize: CGSize, rect:CGRect , show: Binding<Bool>, currentSpot: Binding<Int>, properties:BoundsKeyProperties, onTap:@escaping()->())-> some View{
        Rectangle()
            .fill(.ultraThinMaterial)
            .environment(\.colorScheme, .dark)
            .opacity(show.wrappedValue ? 1 : 0)
            .overlay(alignment: (properties.placeholderAlignment == .bottom) ? .top : .top) {

                
                VStack{
                    properties.text
                        .font(.system(size: 14))
                      .foregroundColor(Color(red: 0.26, green: 0.32, blue: 0.38))
                      .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                      .padding()
                    
                    HStack{
                        ZStack{
                            Text("Next")
                                .font(.system(size: 14, weight: .medium))
                              .multilineTextAlignment(.center)
                              .foregroundColor(.white)
                        }
                        .frame(width: 80, height: 40, alignment: .center)
                        .background(Color(red: 0.92, green: 0.51, blue: 0.25))
                        .cornerRadius(6)
                    }
                    .padding(.bottom)
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(10)
                .padding(.horizontal, 40)
                    .opacity(0)
                    .overlay(alignment:(properties.placeholderAlignment == .bottom) ? .bottom : .bottom) {
                        GeometryReader{ proxy in
                            let textSize = proxy.size
                            
                            VStack{
                                properties.text
                                    .font(.system(size: 14))
                                  .foregroundColor(Color(red: 0.26, green: 0.32, blue: 0.38))
                                  .frame(maxWidth: .infinity, alignment: .topLeading)
                                  .padding()
                                
                                HStack{
                                    ZStack{
                                        Text("Next")
                                            .font(.system(size: 14, weight: .medium))
                                          .multilineTextAlignment(.center)
                                          .foregroundColor(.white)
                                    }
                                    .frame(width: 80, height: 40, alignment: .center)
                                    .background(Color(red: 0.92, green: 0.51, blue: 0.25))
                                    .cornerRadius(6)
                                }
                                .padding(.bottom)
                            }
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                            .offset(y:(properties.placeholderAlignment == .bottom) ? 0 : -textSize.height)

                            

                                

                        }
                        .offset(y:(properties.placeholderAlignment == .bottom) ? (rect.maxY + 11) : rect.minY - 11)
                        
                        

                    }
            }
            .mask {
                Rectangle()
                    .overlay(alignment: .topLeading) {
                        let radius = properties.shape == .circle ? (rect.width / 2) : (properties.shape == .rectangle ? 0 : properties.radius)
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .frame(width: rect.width, height: rect.height)
                            .offset(x: rect.minX, y: rect.minY)
                            .blendMode(.destinationOut)
                    }
            }
            .onTapGesture {
                onTap()
            }
    }
    
    
}


enum SpotlightShape{
    case circle
    case rectangle
    case rounded
}

enum SpotlightAlignment{
    case top
    case bottom
}


struct BoundsKey:PreferenceKey{
    static var defaultValue: [Int:BoundsKeyProperties] = [:]
    
    static func reduce(value: inout [Int : BoundsKeyProperties], nextValue: () -> [Int : BoundsKeyProperties]) {
        value.merge(nextValue()){$1}
    }
}

struct BoundsKeyProperties{
    var shape: SpotlightShape
    var anchor: Anchor<CGRect>
    var text:Text
    var radius:CGFloat = 0
    var placeholderAlignment:SpotlightAlignment
}
