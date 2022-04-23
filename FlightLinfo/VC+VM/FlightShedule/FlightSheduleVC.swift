//
//  FlightSheduleVC.swift
//  FlightLinfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import UIKit

class FlightSheduleVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var flightsTableView: UITableView!
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    //MARK: - Variables
    var vm = FlightSheduleVM()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        registerXibs()
        setupUI()
        getFlightSshedule()
    }
    
    func setupUI(){
        // set up activity indicator
        activityIndicator.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
                activityIndicator.color = UIColor.purple
        self.view.addSubview(activityIndicator)
    }
    
    func stopActivityIndicator(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }

}

//TableView
extension FlightSheduleVC: UITableViewDataSource, UITableViewDelegate{
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.flightsTableView.reloadData()
        }
    }
    
    func setupTableView(){
        flightsTableView.delegate = self
        flightsTableView.dataSource = self
    }
    
    func registerXibs(){
        flightsTableView.register(UINib(nibName: "FlightTVC", bundle: nil), forCellReuseIdentifier: "FlightTVC")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.vm.flighShedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = flightsTableView.dequeueReusableCell(withIdentifier: "FlightTVC") as! FlightTVC
        cell.callBackMore = {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FlightDataVC") as! FlightDataVC
            vc.vm.shedule = self.vm.flighShedules[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        cell.vm.sheduleData = self.vm.flighShedules[indexPath.row]
        cell.configCell()
        return cell
    }
}

//APi Call
extension FlightSheduleVC{
    func getFlightSshedule(){
        self.activityIndicator.startAnimating()
        self.vm.getFlightListWithAirlineName { status, code, message in
            self.stopActivityIndicator()
            if status{
                self.reloadTableView()
            }else{
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
