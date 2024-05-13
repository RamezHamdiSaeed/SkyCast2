//
//  HourlyForcastView.swift
//  SkyCast2
//
//  Created by Ramez Hamdi Saeed on 13/05/2024.
//

import SwiftUI

struct HourlyForcastView: View {
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"] // Sample data
    let hourlyConditions : [WeatherConditionCellModel] = [WeatherConditionCellModel(time: "01:00", imagePath: "https://cdn.weatherapi.com/weather/64x64/day/113.png", temp: "20"),
        WeatherConditionCellModel(time: "02:00", imagePath: "https://cdn.weatherapi.com/weather/64x64/day/113.png", temp: "20"),
    ]
    var body: some View {
        NavigationView{
            ZStack{
                Image("day")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                List(){
                    ForEach(hourlyConditions, id: \.self) { item in
                        HStack(spacing:60){
                            Text(item.time)
                                .font(.system(size: 24,
                                              weight: .bold,
                                              design: .default))
                                .frame(width: 70,height: 50)
                            
                            AsyncImage(url: URL(string: item.imagePath))
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
                            Text(item.temp + "°")
                                .font(.system(size: 24,
                                              weight: .bold,
                                              design: .default))
                                .frame(width: 50,height: 50)
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Hourly Forcast")
                .padding()
            }
            
        }
    }
}

struct HourlyForcastView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForcastView()
    }
}
