//
//  HourlyForcastView.swift
//  SkyCast2
//
//  Created by Ramez Hamdi Saeed on 13/05/2024.
//

import SwiftUI

struct HourlyForcastView: View {
   @Binding var hourlyConditions : [WeatherConditionCellModel]
    
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
                        HStack(spacing:30){
                            Text(item.time)
                                .font(.system(size: 24,
                                              weight: .bold,
                                              design: .default))
                                .frame(width: 70,height: 50)
                            
                            AsyncImage(url: URL(string:"https:\(item.imagePath)"))
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
                                .frame(width: 80,height: 50)
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

