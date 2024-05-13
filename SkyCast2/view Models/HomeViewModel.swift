//
//  HomeViewModel.swift
//  SkyCast2
//
//  Created by Ramez Hamdi Saeed on 13/05/2024.
//

import Foundation
class HomeViewModel: ObservableObject {
    
    @Published var locationResponse: LocationResponse?
    
    func getDataFromModel() {
        NetworkService().fetchLocationWeatherConditions { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.locationResponse = result
            }
        }
    }
}
