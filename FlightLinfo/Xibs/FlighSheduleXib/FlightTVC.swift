//
//  FlightTVC.swift
//  FlightLinfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import UIKit

class FlightTVC: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var flightBgView: UIView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var depatureIataLabel: UILabel!
    @IBOutlet weak var arivalIataLabel: UILabel!
    @IBOutlet weak var depatureatimeLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var aitportLabel: UILabel!
    
    //MARK: - Variables
    var vm = FlightTVCVM()
    var callBackMore : (() -> ())?
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    //MARK: - Custom Functions
    func setupUI(){
        flightBgView.layer.cornerRadius = 10
        flightBgView.addShadow(opacity: 0.5, offSet: CGSize(width: 0, height: 0), radius: 3)
        moreButton.layer.cornerRadius = 10
        flightBgView.addShadow(opacity: 0.3, offSet: CGSize(width: 0, height: 0), radius: 3)
    }
    
    func configCell(){
        depatureIataLabel.text = self.vm.sheduleData?.departure?.iata ?? ""
        arivalIataLabel.text = self.vm.sheduleData?.arrival?.iata ?? ""
        dateLabel.text = self.vm.sheduleData?.flightDate ?? "N/A"
        depatureatimeLabel.text = Helpers.parseApiDateString(self.vm.sheduleData?.departure?.estimated ?? "", format: .dateformateHHMMA)
        arrivalTimeLabel.text = Helpers.parseApiDateString(self.vm.sheduleData?.arrival?.estimated ?? "", format: .dateformateHHMMA)
        
        guard let depatureAirport = self.vm.sheduleData?.departure?.airport, let arrivalAirPort =  self.vm.sheduleData?.arrival?.airport else{
            aitportLabel.text = "N/A"
            return
        }
        
        aitportLabel.text = depatureAirport + " to " + arrivalAirPort
        
    }
    
    //MARK: - Actions
    @IBAction func tappedMore(_ sender: Any) {
        callBackMore?()
    }
    
}
