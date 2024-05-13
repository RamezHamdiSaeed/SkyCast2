//
//  ContentView.swift
//  SkyCast2
//
//  Created by Ramez Hamdi Saeed on 12/05/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel:HomeViewModel = HomeViewModel()
    
//    @State var products : [Product] = []
    @State var weatherApiData : WeatherData?
    @State var hourlyWeatherForecast :[ WeatherConditionCellModel] = [WeatherConditionCellModel(time: "00:00", imagePath: "https://cdn.weatherapi.com/weather/64x64/day/116.png", temp: "0")]
    var body: some View {
        NavigationView{
            ZStack{
                Image("day")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Text(weatherApiData?.location?.name ?? "City")
                        .font(.system(size: 48,
                                      weight: .medium,
                                      design: .default))
                        .frame(width: 100,height: 50)
                        .padding(.top, 20)
                    
                    Text("\(Int(weatherApiData?.current?.tempC ?? 0.0)) °")
                        .font(.system(size: 48,
                                      weight: .medium,
                                      design: .default))
                        .frame(width: 400,height: 50)
                    
                    Text("\(weatherApiData?.current?.condition?.text ?? "current Condition Desc")")
                        .font(.system(size: 32,
                                      weight: .medium,
                                      design: .default))
                        .frame(width: 400,height: 50)
                    
                    Text("H: \(Int(weatherApiData?.forecast?.forecastday?[0].day?.maxtempC ?? 0.0)) ° L: \(Int(weatherApiData?.forecast?.forecastday?[0].day?.mintempC ?? 0.0)) °")
                        .font(.system(size: 32,
                                      weight: .medium,
                                      design: .default))
                        .frame(width: 400,height: 50)
                    
                    AsyncImage(url: URL(string: "https:\(weatherApiData?.current?.condition?.icon ?? "//cdn.weatherapi.com/weather/64x64/day/116.png")"))
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
                            WeatherConditionValue(condition: "Visiblility", value: "\(weatherApiData?.current?.visKm ?? 0)", measureUnit: "KM")
                            WeatherConditionValue(condition: "Humidity", value: "\(weatherApiData?.current?.humidity ?? 0)", measureUnit: "%")
                        }
                        HStack{
                            WeatherConditionValue(condition: "Feels Like", value: "\(weatherApiData?.current?.feelslikeC ?? 0)", measureUnit: "°")
                            WeatherConditionValue(condition: "Pressure", value: "\(weatherApiData?.current?.pressureMb ?? 0)", measureUnit: "")
                        }
                    }
                    Spacer()
                    NavigationLink(destination: HourlyForcastView(hourlyConditions: $hourlyWeatherForecast)) {
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
                .onAppear {
                    homeViewModel.getDataFromModel()
                }
                .onReceive(homeViewModel.$weatherDataResponse) { response in
                    print(response ?? "no data retreived over the network")
                    self.weatherApiData = response
                    
                    // prepare the data to be sent to HourlyForcastView
                    hourlyWeatherForecast = []
                    weatherApiData?.forecast?.forecastday?[0].hour?.forEach{ hour in
                         var time : String = "00:00"
                        if let spaceIndex = hour.time!.firstIndex(of: " ") {
                            let charactersAfterSpace = hour.time![(hour.time?.index(after: spaceIndex)...)!]
                            time = String(charactersAfterSpace)
                        }
                        hourlyWeatherForecast.append(WeatherConditionCellModel(time: time, imagePath: hour.condition?.icon ?? "https://cdn.weatherapi.com/weather/64x64/day/116.png",
                                                                               temp: String(hour.tempC ?? 0.0)))
                    }
                    
                }
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
