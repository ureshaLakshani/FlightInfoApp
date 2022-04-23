//
//  FlightVM.swift
//  FlightLinfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import Foundation

class FlightSheduleVM{
    
    //MARK: - Variables
    let networkManager = NetworkManager()
    var flighShedules : [Datum] = []
    var airlineName: String?
    
}

//API Call
extension FlightSheduleVM{
    
    func getFlightListWithAirlineName(completion: @escaping CompletionHandler){
        
        guard let name = airlineName else{
            completion(false, 404, "Could't find airline name")
            return
        }
        
        //To remove duplicate spaces from url parameter
        let airlineName = name.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)

        networkManager.getFlightAirineName(page: 1, name: airlineName) { flight, error in
            if error != nil{
                completion(false, 978, error ?? "")
            }else{
                self.flighShedules = flight?.data ?? []
                completion(true, 200, "Success")
            }
        }
    }
}

