//
//  ContentView.swift
//  SkyCast2
//
//  Created by Ramez Hamdi Saeed on 12/05/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("day")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Text("City")
                        .font(.system(size: 48,
                                      weight: .medium,
                                      design: .default))
                        .frame(width: 100,height: 50)
                        .padding(.top, 20)
                    
                    Text("avg Temp")
                        .font(.system(size: 48,
                                      weight: .medium,
                                      design: .default))
                        .frame(width: 400,height: 50)
                    
                    Text("weather describtion")
                        .font(.system(size: 32,
                                      weight: .medium,
                                      design: .default))
                        .frame(width: 400,height: 50)
                    
                    Text("H: 20° L: 10°")
                        .font(.system(size: 32,
                                      weight: .medium,
                                      design: .default))
                        .frame(width: 400,height: 50)
                    
                    AsyncImage(url: URL(string: "https://cdn.weatherapi.com/weather/64x64/day/113.png"))
                    { phase in
                        switch phase {
                                  case .success(let image):
                                      image
                                          .resizable()
                                  case .failure:
                                      // Placeholder or error handling
                                      Text("Failed to load image")
                                  @unknown default:
                                      EmptyView()
                                  }
                    }
                        .frame(width: 100, height: 100)
                    
                    VStack(spacing:20) {
                        HStack{
                            WeatherConditionValue(condition: "Visiblility", value: "10", measureUnit: "KM")
                            WeatherConditionValue(condition: "Humidity", value: "36", measureUnit: "%")
                        }
                        HStack{
                            WeatherConditionValue(condition: "Feels Like", value: "16", measureUnit: "°")
                            WeatherConditionValue(condition: "Humidity", value: "1200", measureUnit: "")
                        }
                    }
                    Spacer()
                    NavigationLink(destination: HourlyForcastView()) {
                        Text("Hourly Forecast")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .frame(width: 200, height: 50)
                            .background(Color.white)
                            .foregroundColor(.blue) // Add text color for better visibility
                            .cornerRadius(20)
                    }

                    Spacer()
                }
                .navigationTitle("Home")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct WeatherConditionValue: View {
     var condition : String
     var value : String
     var measureUnit : String
    var body: some View {
        VStack{
            Text("\(self.condition)")
                .font(.system(size: 24,
                              weight: .bold,
                              design: .default))
                .frame(width: 150,height: 50)
            Text("\(self.value) \(self.measureUnit)")
                .font(.system(size: 32,
                              weight: .regular,
                              design: .default))
                .frame(width: 150,height: 50)
        }
    }
}
