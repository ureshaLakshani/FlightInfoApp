//
//  AirlineVC.swift
//  FlightLinfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import UIKit

class AirlineVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var airlinesTableView: UITableView!
    
    //MARK: - Variables
        let vm = AirlineVM()
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

        //MARK: - LifeCycle
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            setupTableView()
            registerXibs()
            getAirlineList()
        }
        
        func setupUI(){
            
            // set up activity indicator
            activityIndicator.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
                    activityIndicator.color = UIColor.purple
            self.view.addSubview(activityIndicator)
        }
        
        @IBAction func tappedLogout(_ sender: Any) {
            self.logoutConfirmation()
        }
        
        func stopActivityIndicator(){
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
        
    }

    //TableView
    extension AirlineVC: UITableViewDataSource, UITableViewDelegate{
        
        func reloadTableView(){
            DispatchQueue.main.async {
                self.airlinesTableView.reloadData()
            }
        }
        
        func setupTableView(){
            airlinesTableView.delegate = self
            airlinesTableView.dataSource = self
        }
        
        func registerXibs(){
            airlinesTableView.register(UINib(nibName: "AirelineTVC", bundle: nil), forCellReuseIdentifier: "AirelineTVC")
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            self.vm.airlinesData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = airlinesTableView.dequeueReusableCell(withIdentifier: "AirelineTVC") as! AirelineTVC
            cell.vm.airline = self.vm.airlinesData[indexPath.row]
            cell.configCell()
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FlightSheduleVC") as! FlightSheduleVC
            vc.vm.airlineName = self.vm.airlinesData[indexPath.row].name
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }

    //ScrollView + Pagination
    extension AirlineVC{
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if scrollView == airlinesTableView{
                let height = scrollView.frame.size.height
                let contentYoffset = scrollView.contentOffset.y
                let distanceFromBottom = scrollView.contentSize.height - contentYoffset
                if distanceFromBottom < height {
                    
                    if self.vm.isScrolling{
                        self.vm.isScrolling = false
                        guard let offset = self.vm.pagination?.offset, let count = self.vm.pagination?.total, let limit = self.vm.pagination?.limit else{
                            return
                        }
                        
                        if offset < (count/limit){
                            self.vm.offSet += 1
                            print(self.vm.pagination?.offset)
                            self.getAirlineList()
                        }
                        
                    }
                }
            }
        }
    }

    //Alert
    extension AirlineVC{
        func logoutConfirmation(){
            let refreshAlert = UIAlertController(title: "Conformation", message: "Are you sure want to logout from app?", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                self.vm.logOutFromFirebaseUser()
            }))
            refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
                 
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }

    //MARK:- API Call
    extension AirlineVC{
        func getAirlineList(){
            self.activityIndicator.startAnimating()
            self.vm.getFlightList { status, code, message in
                self.stopActivityIndicator()
                if status{
                    self.reloadTableView()
                    self.vm.isScrolling = true
                }else{
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
