//
//  AirelineTVC.swift
//  FlightLinfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import UIKit

class AirelineTVC: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var airlineBgView: UIView!
    @IBOutlet weak var airLineInfoLabel: UILabel!
    
    //MARK: - Variables
    var vm = AirlineTVCVM()
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    //MARK: - Custom Functions
    func setupUI(){
        airlineBgView.layer.cornerRadius = 5
        airlineBgView.addShadow(opacity: 0.4, offSet: CGSize(width: 0, height: 0), radius: 3)
    }
    
    func configCell(){
        guard let airlineName = vm.airline?.name, let airlineIata = vm.airline?.iata, let airlineIcao =  vm.airline?.icao else{
            airLineInfoLabel.text = "N/A Name"
            return
        }
        
        airLineInfoLabel.text = airlineName + " (" + airlineIata + "/" + airlineIcao + ")"
    }
    
}
