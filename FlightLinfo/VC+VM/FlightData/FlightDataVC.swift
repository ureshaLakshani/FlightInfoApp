//
//  FlightDataVC.swift
//  FlightLinfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import UIKit
import MapKit
import Lottie

class FlightDataVC: UIViewController {
    
    //MARK: - outlets
    @IBOutlet weak var flightNoLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var flightStatusLbl: UILabel!
    
    @IBOutlet weak var depatureIataLbl: UILabel!
    @IBOutlet weak var depatureAirportLbl: UILabel!
    @IBOutlet weak var terminalGateLbl: UILabel!
    @IBOutlet weak var depatureTimeLbl: UILabel!
    @IBOutlet weak var depatureDelayTime: UILabel!
    
    @IBOutlet weak var arrivalIataLbl: UILabel!
    @IBOutlet weak var arrivalAirportLbl: UILabel!
    @IBOutlet weak var arrivalterminalGateLbl: UILabel!
    @IBOutlet weak var arrivalTimeLbl: UILabel!
    @IBOutlet weak var arrivalDelayTime: UILabel!
    
    @IBOutlet weak var flightMapView: MKMapView!
    
    @IBOutlet weak var animationView: AnimationView!
    
    //MARK: - Variables
    var vm = FlightDataVM()
    let annotation =  MKPointAnnotation()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        
        //set naviagtion bar title
        self.title = "Flight Data"

    }
    
    //Custom UI setup Func
    func setupUI(){
        displayAnimationGif()
      
        flightNoLbl.text = self.vm.shedule?.flight?.number ?? "N/A"
        dateLbl.text = self.vm.shedule?.flightDate ?? "N/A"
        flightStatusLbl.text = self.vm.shedule?.flightStatus ?? "N/A"
        
        depatureIataLbl.text = self.vm.shedule?.departure?.iata ?? "N/A"
        depatureAirportLbl.text = self.vm.shedule?.departure?.airport ?? "N/A"
        
        if let terminal = self.vm.shedule?.departure?.terminal, let gate = self.vm.shedule?.departure?.gate{
            terminalGateLbl.text = terminal + " + " + gate
        }else{
            terminalGateLbl.text = "N/A Terminal"
        }
        
        depatureTimeLbl.text = Helpers.parseApiDateString(self.vm.shedule?.departure?.estimated ?? "", format: .dateformateHHMMA)
        depatureDelayTime.text = "\(self.vm.shedule?.departure?.delay ?? 0) min delay"
        
        arrivalIataLbl.text = self.vm.shedule?.arrival?.iata ?? "N/A"
        arrivalAirportLbl.text = self.vm.shedule?.arrival?.airport ?? "N/A"
        
        if let arrivalTerminal = self.vm.shedule?.arrival?.terminal, let arrivalGate = self.vm.shedule?.arrival?.gate{
            terminalGateLbl.text = arrivalTerminal + " + " + arrivalGate
        }else{
            terminalGateLbl.text = "N/A Terminal"
        }
        
        arrivalTimeLbl.text = Helpers.parseApiDateString(self.vm.shedule?.arrival?.estimated ?? "", format: .dateformateHHMMA)
        arrivalDelayTime.text = "\(self.vm.shedule?.arrival?.delay ?? 0) min delay"
        
        guard let lat = self.vm.shedule?.live?.latitude, let long = self.vm.shedule?.live?.longitude else{
            flightMapView.isHidden = true
            return
        }
        
        flightMapView.isHidden = false
        let flightLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation.coordinate = flightLocation
        annotation.title = "Your flight is here"
        flightMapView.addAnnotation(annotation)
        
        //Center the map on the place location
        flightMapView.setCenter(flightLocation, animated: true)
        
    }

    // call fuction to display noItem Gif
       func displayAnimationGif(){
             //  Set animation content mode
           animationView.contentMode = .scaleAspectFit
              //Set animation loop mode
           animationView.loopMode = .loop
              //Adjust animation speed
           animationView.animationSpeed = 0.5
              //Play animation
           animationView.play()
           
       }
}

//Map View
extension FlightDataVC: MKMapViewDelegate{
    
    func setupDelegate(){
        flightMapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           
           guard !(annotation is MKUserLocation) else {
               return nil
           }
           
           let annotationIdentifier = "Identifier"
           var annotationView: MKAnnotationView?
           if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
               annotationView = dequeuedAnnotationView
               annotationView?.annotation = annotation
           }
           else {
               annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
               annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
           }
           
           if let annotationView = annotationView {
               
               annotationView.canShowCallout = true
               let pinImage = UIImage(named: "plane")
               
               let size = CGSize(width: 40, height: 40)
               UIGraphicsBeginImageContext(size)
               pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
               let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
               annotationView.image = resizedImage
               
           }
           return annotationView
       }

}
