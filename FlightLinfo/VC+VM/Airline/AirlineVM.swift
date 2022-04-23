//
//  AirlineVM.swift
//  FlightLinfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import Foundation

class AirlineVM{
    
    //MARK: - Variables
    let networkManager = NetworkManager()
    var airlinesData : [Airline] = []
    var pagination: Pagination?
    var isScrolling: Bool = true
    var isPaging: Bool = false
    var offSet = 0
    
    //Logout
    func logOutFromFirebaseUser(){
        FirebaseManager.shared.logOut()
    }
    
}

//API Call
extension AirlineVM{
    func getFlightList(completion: @escaping CompletionHandler){
        networkManager.getFlights(page: offSet) { flight, error in
            if error != nil{
                completion(false, 978, error ?? "")
            }else{
                self.pagination = flight?.pagination
                for shedule in flight?.data ?? []{
                    if let airline = shedule.airline{
                        self.airlinesData.append(airline)
                    }
                }
                completion(true, 200, "Success")
            }
        }
    }
}
